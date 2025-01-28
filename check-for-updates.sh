#!/bin/bash

set -e

script_dir=$(dirname "$0")

normalize_version() {
  if [[ "$1" == v* ]]; then
    echo "${1:1}"
  else
    echo "$1"
  fi
}

curl_github() {
  curl "$1" \
    --header "Authorization: Bearer ${GITHUB_TOKEN}" \
    --header "X-GitHub-Api-Version: 2022-11-28" \
    -s
}

check_version() {
  version_var=$1
  repo=$2
  version=$(normalize_version $3)
  auto_update=$4

  latest=$(curl_github "https://api.github.com/repos/${repo}/releases/latest" | jq -r .tag_name)
  normalized_latest=$(normalize_version "$latest")
  if [ "$version" != "$normalized_latest" ]; then
    release_url="http://github.com/${repo}/releases/${latest}"
    warn "${repo} update available: we're using ${version} but latest is ${latest}: ${release_url}"
    if [ "${auto_update}" == "1" ]; then
      info "updating version in versions.sh for ${dependency} to ${normalized_latest}"
      sed -i "s/^${version_var}=.*$/${version_var}=${normalized_latest}/g" "${script_dir}/versions.sh"
    fi
    return 0
  else
    success "${repo} is up to date"
    return 1
  fi
}

print_usage() {
  echo "Usage: $0 [-a]"
  exit 1
}

main() {
  source "${script_dir}/versions.sh"
  source "${script_dir}/logging.sh"
  source "${script_dir}/.env"
  if test -d "$VENV_PATH"; then
    source "$VENV_PATH/bin/activate"
  fi

  while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
      print_usage $0
      ;;
    -a | --auto-update)
      auto_update=1
      shift
      ;;
    -* | --*)
      echo "Unknown option $1"
      exit 1
      ;;
    esac
  done

  any_updates=0
  dependencies=(nvim fzf gh alacritty mold delta tmux uv pyright ruff jq)
  for dependency in "${dependencies[@]}"; do
    repo_var="${dependency^^}_REPO"
    version_var="${dependency^^}_VERSION"
    if check_version "${version_var}" "${!repo_var}" "${!version_var}" "${auto_update}"; then
      any_updates=1
    fi
  done
  if [ "$any_updates" -eq 1 ] && [ "$auto_update" == "1" ]; then
    warn "updates found, running install script"
    "${script_dir}/install.sh"
  fi
}

main $@
