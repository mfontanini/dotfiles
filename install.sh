#!/usr/bin/env bash

script_dir=$(dirname "$0")

mkdir -p ~/.config

pushd $script_dir
stow --target="$HOME" -v .

if [ $? -ne 0 ]; then
	echo "stow failed!"
	exit 1
fi

fc-cache -fv
