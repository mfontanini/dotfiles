#!/usr/bin/env bash

set -euo pipefail

curl_github() {
  curl "$1" \
    --header "Authorization: Bearer ${GITHUB_TOKEN}" \
    --header "X-GitHub-Api-Version: 2022-11-28" \
    -L \
    -s ${@:2}
}

install_binary() {
  if [ $# -ne 2 ]; then
    error "Usage: install_binary url path"
  fi
  url="$1"
  filename="$2"
  temp_file=$(mktemp)
  curl_github "$url" -o "$temp_file"
  chmod +x "$temp_file"
  mv "$temp_file" "${HOME}/.local/bin/${filename}"
}

install_tar_binary() {
  if [ $# -ne 3 ]; then
    error "Usage: install_binary url path tar-file"
  fi
  url="$1"
  filename="$3"
  temp_dir=$(mktemp -d)
  pushd $temp_dir >/dev/null
  tar_path="x.tar.gz"
  curl_github "$url" -o "$tar_path"
  tar xvf "$tar_path" >/dev/null

  mv "${2}" "${HOME}/.local/bin/${filename}"
  popd >/dev/null
}

install_neovim() {
  if nvim --version 2>/dev/null | head -n 1 | grep "^NVIM v${NVIM_VERSION}$" >/dev/null; then
    info neovim is up to date
  else
    warn installing neovim ${NVIM_VERSION}...
    install_binary \
      "https://github.com/${NVIM_REPO}/releases/download/v${NVIM_VERSION}/nvim.appimage" \
      nvim
    info neovim installed
  fi
}

install_fzf() {
  if fzf --version 2>/dev/null | grep "^${FZF_VERSION} " >/dev/null; then
    info fzf is up to date
  else
    warn installing fzf ${FZF_VERSION}...
    install_tar_binary "https://github.com/${FZF_REPO}/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
      fzf \
      fzf
    info fzf installed
  fi
}

install_gh() {
  if gh --version 2>/dev/null | grep "^gh version ${GH_VERSION} " >/dev/null; then
    info gh is up to date
  else
    warn installing gh ${GH_VERSION}...
    install_tar_binary \
      "https://github.com/${GH_REPO}/releases/download/v${GH_VERSION}/gh_2.65.0_linux_amd64.tar.gz" \
      "gh_${GH_VERSION}_linux_amd64/bin/gh" \
      gh
    info gh installed
  fi
}

install_jq() {
  if jq -V 2>/dev/null | grep "^${JQ_VERSION}$" >/dev/null; then
    info jq is up to date
  else
    warn installing jq ${JQ_VERSION}...
    install_binary \
      "https://github.com/${JQ_REPO}/releases/download/${JQ_VERSION}/jq-linux64" \
      jq
    info jq installed
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
    install_tar_binary "https://github.com/${DELTA_REPO}/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
      "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta" \
      delta
    info delta installed
  fi
}

install_uv() {
  if uv --version 2>/dev/null | grep "^uv ${UV_VERSION}$" >/dev/null; then
    info uv is up to date
  else
    warn installing uv ${UV_VERSION}...
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-installer.sh | sh
    info uv installed
    if ! test -d "$VENV_PATH"; then
      warn devenv pyenv does not exist, creating
      uv venv "$VENV_PATH"
      info pyenv created at "$VENV_PATH"
    fi
  fi
}

install_pyright() {
  if pyright --version 2>/dev/null | grep "^pyright ${PYRIGHT_VERSION}$" >/dev/null; then
    info pyright is up to date
  else
    warn installing pyright ${PYRIGHT_VERSION}...
    uv pip install --upgrade pyright
    info pyright installed
  fi
}

install_ruff() {
  if ruff-lsp --version 2>/dev/null | grep "^ruff-lsp ${RUFF_VERSION}$" >/dev/null; then
    info ruff is up to date
  else
    warn installing ruff ${RUFF_VERSION}...
    uv pip install --upgrade ruff-lsp
    info ruff-lsp installed
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
    ./configure --prefix="$HOME/.local" -q --enable-sixel
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
  install_gh
  install_jq
  install_mold
  install_delta
  install_uv
  install_fish
  info all cli tools installed
}

install_python_tools() {
  info installing python tools
  install_pyright
  install_ruff
  info all python tools installed
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
source "${script_dir}/.env"
pushd "$script_dir" >/dev/null || exit

apt_install_core_tools
symlink_dotfiles
install_cli_tools

# python, not even once
source "$VENV_PATH/bin/activate"
install_python_tools
if ! env | grep -e "^NO_GUI_TOOLS=" >/dev/null; then
  install_gui_tools
fi
