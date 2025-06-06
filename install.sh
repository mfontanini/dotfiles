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
  info downloading $url
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
  info downloading $url
  curl_github "$url" -o "$tar_path"
  tar xvf "$tar_path" >/dev/null

  info installing binary ${2}
  mv "${2}" "${HOME}/.local/bin/${filename}"
  popd >/dev/null
}

install_neovim() {
  if nvim --version 2>/dev/null | head -n 1 | grep "^NVIM v${NVIM_VERSION}$" >/dev/null; then
    success neovim is up to date
  else
    warn installing neovim ${NVIM_VERSION}...
    install_binary \
      "https://github.com/${NVIM_REPO}/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.appimage" \
      nvim
    success neovim installed
  fi
}

install_fzf() {
  if fzf --version 2>/dev/null | grep "^${FZF_VERSION} " >/dev/null; then
    success fzf is up to date
  else
    warn installing fzf ${FZF_VERSION}...
    install_tar_binary "https://github.com/${FZF_REPO}/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
      fzf \
      fzf
    success fzf installed
  fi
}

install_bat() {
  if bat --version 2>/dev/null | grep "^bat ${BAT_VERSION}" >/dev/null; then
    success bat is up to date
  else
    warn installing bat ${FD_VERSION}...
    install_tar_binary \
      "https://github.com/${BAT_REPO}/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz" \
      "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" \
      bat
    success bat installed
  fi
}

install_gh() {
  if gh --version 2>/dev/null | grep "^gh version ${GH_VERSION} " >/dev/null; then
    success gh is up to date
  else
    warn installing gh ${GH_VERSION}...
    install_tar_binary \
      "https://github.com/${GH_REPO}/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz" \
      "gh_${GH_VERSION}_linux_amd64/bin/gh" \
      gh
    success gh installed
  fi
}

install_fd() {
  if fd --version 2>/dev/null | grep "^fd ${FD_VERSION}" >/dev/null; then
    success fd is up to date
  else
    warn installing fd ${FD_VERSION}...
    install_tar_binary \
      "https://github.com/${FD_REPO}/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz" \
      "fd-v${FD_VERSION}-x86_64-unknown-linux-musl/fd" \
      fd
    success fd installed
  fi
}

install_rg() {
  if rg -V 2>/dev/null | grep "^ripgrep ${RG_VERSION}" >/dev/null; then
    success rg is up to date
  else
    warn installing rg ${FD_VERSION}...
    install_tar_binary \
      "https://github.com/${RG_REPO}/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz" \
      "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" \
      rg
    success rg installed
  fi
}

install_jq() {
  if jq -V 2>/dev/null | grep "^${JQ_VERSION}$" >/dev/null; then
    success jq is up to date
  else
    warn installing jq ${JQ_VERSION}...
    install_binary \
      "https://github.com/${JQ_REPO}/releases/download/${JQ_VERSION}/jq-linux64" \
      jq
    success jq installed
  fi
}

install_alacritty() {
  if alacritty -V 2>/dev/null | grep "^alacritty ${ALACRITTY_VERSION}$" >/dev/null; then
    success alacritty is up to date
  else
    warn installing alacritty ${ALACRITTY_VERSION}...
    cargo install -q alacritty
    success alacritty installed
  fi
}

install_mold() {
  if mold --version 2>/dev/null | grep "^mold ${MOLD_VERSION} " >/dev/null; then
    success mold is up to date
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
    success mold installed
  fi
}

install_delta() {
  if delta -V 2>/dev/null | grep "^delta ${DELTA_VERSION}$" >/dev/null; then
    success delta is up to date
  else
    warn installing delta ${DELTA_VERSION}...
    install_tar_binary "https://github.com/${DELTA_REPO}/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
      "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta" \
      delta
    success delta installed
  fi
}

install_uv() {
  if uv --version 2>/dev/null | grep "^uv ${UV_VERSION}$" >/dev/null; then
    success uv is up to date
  else
    warn installing uv ${UV_VERSION}...
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-installer.sh | sh
    success uv installed
  fi
}

install_pyright() {
  if "${VENV_PATH}/bin/pyright" --version 2>/dev/null | grep "^pyright ${PYRIGHT_VERSION}$" >/dev/null; then
    success pyright is up to date
  else
    warn installing pyright ${PYRIGHT_VERSION}...
    uv pip install --upgrade pyright
    success pyright installed
  fi
}

install_ruff() {
  if "${VENV_PATH}/bin/ruff-lsp" --version 2>/dev/null | grep "^ruff-lsp ${RUFF_VERSION}$" >/dev/null; then
    success ruff is up to date
  else
    warn installing ruff ${RUFF_VERSION}...
    uv pip install --upgrade ruff-lsp
    success ruff-lsp installed
  fi
}

install_tmux() {
  if tmux -V 2>/dev/null | grep "^tmux ${TMUX_VERSION}$" >/dev/null; then
    success tmux is up to date
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
    success tmux installed
  fi
}

install_fish() {
  if which fish >/dev/null; then
    success fish is up to date
  else
    warn installing fish shell...
    sudo apt-add-repository -y ppa:fish-shell/release-4 >/dev/null
    sudo apt -qq update
    sudo apt -qq install -y fish >/dev/null
    sudo chsh -s /usr/bin/fish >/dev/null
    success fish shell installed
  fi
}

install_cli_tools() {
  mkdir -p ~/.local/bin
  info installing cli tools
  install_bat
  install_delta
  install_fd
  install_fish
  install_fzf
  install_gh
  install_jq
  install_mold
  install_neovim
  install_rg
  install_tmux
  install_uv
  success all cli tools installed
}

install_python_tools() {
  info installing python tools
  install_pyright
  install_ruff
  success all python tools installed
}

install_gui_tools() {
  info installing gui tools
  install_fonts
  install_alacritty
  success all gui tools installed
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
    success all core tools are installed
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
mkdir -p "$VENV_PATH"
uv venv --allow-existing -q "$VENV_PATH"
source "$VENV_PATH/bin/activate"
install_python_tools
if ! env | grep -e "^NO_GUI_TOOLS=" >/dev/null; then
  install_gui_tools
fi
