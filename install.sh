#!/usr/bin/env bash

script_dir=$(dirname "$0")

mkdir -p ~/.config

pushd $script_dir
stow --target="$HOME" -v .

fc-cache -fv
