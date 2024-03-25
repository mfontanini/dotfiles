#!/usr/bin/env bash

set -e

ALACRITTY_VERSION=0.13.2
DELTA_VERSION=0.17.0
FZF_VERSION=0.48.1
MOLD_VERSION=2.30.0
NVIM_VERSION=0.9.5
TMUX_VERSION=3.4

info_icon='\033[0;34mi\033[0m'
success_icon='\033[0;32m✔\033[0m'
warn_icon='\033[0;33m⚠️\033[0m'
error_icon='\033[0;31m✗\033[0m'

info() {
  echo -e "${info_icon} $*"
}

success() {
  echo -e "${success_icon} $*"
}

warn() {
  echo -e "${warn_icon}$*"
}

error() {
  echo -e "${error_icon} $*"
}

install_neovim() {
  if nvim --version 2>/dev/null | head -n 1 | grep "^NVIM v${NVIM_VERSION}$" >/dev/null; then
    info neovim is up to date
  else
    warn installing neovim ${NVIM_VERSION}...
    url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage"
    wget $url -O ~/.local/bin/nvim 2>/dev/null
    chmod +x ~/.local/bin/nvim
    info neovim installed
  fi
}

install_fzf() {
  if fzf --version 2>/dev/null | grep "^${FZF_VERSION} " >/dev/null; then
    info fzf is up to date
  else
    warn installing fzf ${FZF_VERIONS}...
    temp=$(mktemp -d)
    filename="fzf-${FZF_VERSION}-linux_amd64.tar.gz"
    pushd "$temp" >/dev/null
    wget "https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/${filename}" 2>/dev/null
    tar xvzf "$filename" >/dev/null
    mv fzf ~/.local/bin/fzf
    popd >/dev/null
    info fzf installed
  fi
}

install_alacritty() {
  if alacritty -V 2>/dev/null | grep "^alacritty ${ALACRITTY_VERSION}$" >/dev/null; then
    info alacritty is up to date
  else
    warn installing alacritty ${ALACRITTY_VERSION}...
    cargo install -q alacritty
    info alacritty installed
  fi
}

install_mold() {
  if mold --version 2>/dev/null | grep "^mold ${MOLD_VERSION} " >/dev/null; then
    info mold is up to date
  else
    warn installing mold ${MOLD_VERSION}...
    dir="mold-${MOLD_VERSION}-x86_64-linux"
    filename="${dir}.tar.gz"
    temp=$(mktemp -d)
    pushd "$temp" >/dev/null
    wget "https://github.com/rui314/mold/releases/download/v${MOLD_VERSION}/${filename}" 2>/dev/null
    tar xvzf "${filename}" >/dev/null
    cp -r ${dir}/* ~/.local
    popd >/dev/null
    info mold installed
  fi
}

install_delta() {
  if delta -V 2>/dev/null | grep "^delta ${DELTA_VERSION}$" >/dev/null; then
    info delta is up to date
  else
    warn installing delta ${DELTA_VERSION}...
    dir="delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu"
    filename="${dir}.tar.gz"
    url="https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/${filename}"
    temp=$(mktemp -d)
    pushd "$temp" >/dev/null
    wget "$url" 2>/dev/null
    tar xvzf "$filename" >/dev/null
    cp "${dir}/delta" ~/.local/bin
    popd >/dev/null
    info delta installed
  fi
}

install_tmux() {
  if tmux -V 2>/dev/null | grep "^tmux ${TMUX_VERSION}$" >/dev/null; then
    info tmux is up to date
  else
    warn installing tmux ${TMUX_VERSION}...
    dir="tmux-${TMUX_VERSION}"
    filename="${dir}.tar.gz"
    url="https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${filename}"
    temp=$(mktemp -d)
    pushd "$temp" >/dev/null
    wget "$url" 2>/dev/null
    tar xvzf "$filename" >/dev/null
    cd "${dir}"
    ./configure --prefix="$HOME/.local" -q
    MAKEFLAGS=--silent make
    MAKEFLAGS=--silent make install
    popd >/dev/null
    info tmux installed
  fi
}

install_fish() {
  if which fish; then
    info fish is up to date
  else
    warn installing fish shell...
    sudo apt-add-repository -y ppa:fish-shell/release-3 >/dev/null
    sudo apt -qq update
    sudo apt -qq install -y fish >/dev/null
    sudo chsh -s /usr/local/bin/fish >/dev/null
    info fish shell installed
  fi
}

install_cli_tools() {
  mkdir -p ~/.local/bin
  info installing cli tools
  install_neovim
  install_tmux
  install_fzf
  install_mold
  install_delta
  install_fish
  info all cli tools installed
}

install_gui_tools() {
  info installing gui tools
  install_fonts
  install_alacritty
  info all gui tools installed
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

apt_install_core_tools() {
  info checking core tools are installed...
  missing=()
  packages=(clang stow wget libevent-dev ncurses-dev build-essential bison pkg-config libfuse2 software-properties-common)
  for package in "${packages[@]}"; do
    if ! dpkg -l "$package" >/dev/null 2>/dev/null; then
      missing+=("$package")
    fi
  done
  if [ "${#missing[@]}" -ne 0 ]; then
    warn installing missing core tools: ${missing[@]}
    sudo apt -qq update
    sudo apt -qq install -y ${missing[@]} >/dev/nulll
  else
    info all core tools are installed
  fi
}

script_dir=$(dirname "$0")
pushd "$script_dir" >/dev/null || exit

apt_install_core_tools
symlink_dotfiles
install_cli_tools
if env | grep "^NO_GUI_TOOLS$"; then
  install_gui_tools
fi
