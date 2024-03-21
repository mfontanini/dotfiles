#!/usr/bin/env bash

set -e

info_icon='\033[0;34mi\033[0m'
success_icon='\033[0;32m✔\033[0m'
error_icon='\033[0;31m✗\033[0m'

info() {
  echo -e "${info_icon} $*"
}

success() {
  echo -e "${success_icon} $*"
}

error() {
  echo -e "${error_icon} $*"
}

check_installed_tools() {
  any_missing=0
  tools=(nvim tmux alacritty fzf delta mold)
  info checking for missing tools...
  for tool in "${tools[@]}"; do
    if ! which "$tool" >/dev/null; then
      error "${tool} is not installed"
      any_missing=1
    fi
  done
  if [ "${any_missing}" -eq 0 ]; then
    success all tools are installed
  fi
}

symlink_dotfiles() {
  mkdir -p ~/.config

  info stowing...

  if stow --target="$HOME" -v .; then
    success stow completed
  else
    error stow failed!
    exit 1
  fi
}

fonts_installed() {
  for font in fonts/*; do
    if fc-list | grep "${font}" >/dev/null; then
      return 0
    fi
  done
  return 1
}

install_fonts() {
  if fonts_installed; then
    success fonts already installed
  else
    info installing fonts...
    fc-cache -f
    success fonts installed
  fi
}

script_dir=$(dirname "$0")
pushd "$script_dir" >/dev/null || exit

symlink_dotfiles
install_fonts
check_installed_tools
