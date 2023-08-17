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

if ! [[ -r ~/.local/share/blesh/ble.sh ]]; then
    if ! [[ -d ~/ble.sh ]]; then
        git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    fi
    make -C ble.sh install PREFIX=~/.local
fi

bash ~/.local/share/blesh/ble.sh --update
