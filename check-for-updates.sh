#!/bin/bash

set -e

script_dir=$(dirname "$0")
source "${script_dir}/versions.sh"
source "${script_dir}/logging.sh"

normalize_version() {
  if [[ "$1" == v* ]]; then
    echo "${1:1}"
  else
    echo "$1"
  fi
}

check_version() {
  repo=$1
  version=$(normalize_version $2)

  latest=$(curl "https://api.github.com/repos/${repo}/releases/latest" -s | jq -r .tag_name)
  latest=$(normalize_version "$latest")
  if [ "$version" != "$latest" ]; then
    warn "${repo} update available: we're using ${version} but latest is ${latest}"
  else
    info "${repo} is up to date"
  fi
}

dependencies=(nvim fzf alacritty mold delta tmux)
for dependency in "${dependencies[@]}"; do
  repo_var="${dependency^^}_REPO"
  version_var="${dependency^^}_VERSION"
  check_version "${!repo_var}" "${!version_var}"
done
