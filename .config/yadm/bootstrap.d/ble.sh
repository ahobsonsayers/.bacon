#!/usr/bin/env bash
#
# Repo
# - https://github.com/akinomyoga/ble.sh
#
set -euo pipefail
IFS=$'\n\t'

echo ----------------------
echo Installing ble.sh
echo ----------------------

# if ! [[ -r ~/.local/share/blesh/ble.sh ]]; then
#     if ! [[ -d ~/ble.sh ]]; then
#         git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
#     fi
#     make -C ble.sh install PREFIX=~/.local
# fi

# bash ~/.local/share/blesh/ble.sh --update

user_name="akinomyoga"
repo_name="ble.sh"
file_name="blesh.tar.xz"
output_dir="$HOME/.local/share/blesh"

release_url="$(
  curl -s https://api.github.com/repos/$user_name/$repo_name/releases/latest |
    grep -o '"browser_download_url": ".*"' |
    cut -d " " -f 2 |
    tr -d '"'
)"

mkdir -p "$output_dir"
wget "$release_url" -O "$file_name"
tar -xf "$file_name" -C "$output_dir" --strip-components=1
rm "$file_name"
