#!/usr/bin/env bash

script_dir=$(dirname "$0")

pushd "$script_dir" >/dev/null || exit

fonts_installed() {
	for font in fonts/*; do
		if fc-list | grep "${font}" >/dev/null; then
			return 0
		fi
	done
	return 1
}

mkdir -p ~/.config

echo "stowing..."

if stow --target="$HOME" -v .; then
	echo "stow done"
else
	echo "stow failed!"
	exit 1
fi

if fonts_installed; then
	echo "fonts already installed"
else
	echo "installing fonts..."
	fc-cache -f
	echo "fonts installed"
fi
