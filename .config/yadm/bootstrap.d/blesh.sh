#!/usr/bin/env bash
#
# Repo
# - https://github.com/akinomyoga/ble.sh
#
set -euo pipefail
IFS=$'\n\t'

if ! [[ -d ~/.ble.sh ]]; then
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C ble.sh install PREFIX=~/.local
    
fi
