#!/usr/bin/env bash

set -e

install_neovim() {
  if nvim --version 2>/dev/null | head -n 1 | grep "^NVIM v${NVIM_VERSION}$" >/dev/null; then
    info neovim is up to date
  else
    warn installing neovim ${NVIM_VERSION}...
    url="https://github.com/${NVIM_REPO}/releases/download/v${NVIM_VERSION}/nvim.appimage"
    temp=$(mktemp)
    wget $url -O "$temp" 2>/dev/null
    chmod +x "$temp"
    mv "$temp" ~/.local/bin/nvim
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
    wget "https://github.com/${FZF_REPO}/releases/download/${FZF_VERSION}/${filename}" 2>/dev/null
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
    wget "https://github.com/${MOLD_REPO}/releases/download/v${MOLD_VERSION}/${filename}" 2>/dev/null
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
    url="https://github.com/${DELTA_REPO}/releases/download/${DELTA_VERSION}/${filename}"
    temp=$(mktemp -d)
    pushd "$temp" >/dev/null
    wget "$url" 2>/dev/null
    tar xvzf "$filename" >/dev/null
    cp "${dir}/delta" ~/.local/bin
    popd >/dev/null
    info delta installed
  fi
}

install_pyright() {
  if pyright --version 2>/dev/null | grep "^pyright ${PYRIGHT_VERSION}$" >/dev/null; then
    info pyright is up to date
  else
    warn installing pyright ${PYRIGHT_VERSION}...
    pip install --upgrade pyright
    info pyright installed
  fi
}

install_tmux() {
  if tmux -V 2>/dev/null | grep "^tmux ${TMUX_VERSION}$" >/dev/null; then
    info tmux is up to date
  else
    warn installing tmux ${TMUX_VERSION}...
    dir="tmux-${TMUX_VERSION}"
    filename="${dir}.tar.gz"
    url="https://github.com/${TMUX_REPO}/releases/download/${TMUX_VERSION}/${filename}"
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
  if which fish >/dev/null; then
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
  install_pyright
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
    sudo apt -qq install -y ${missing[@]} >/dev/null
  else
    info all core tools are installed
  fi
}

script_dir=$(dirname "$0")
source "${script_dir}/versions.sh"
source "${script_dir}/logging.sh"
pushd "$script_dir" >/dev/null || exit

apt_install_core_tools
symlink_dotfiles
install_cli_tools
if env | grep "^NO_GUI_TOOLS$"; then
  install_gui_tools
fi
