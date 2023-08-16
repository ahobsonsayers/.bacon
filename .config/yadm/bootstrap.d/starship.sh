#!/usr/bin/env bash
#
# Website:
# - https://starship.rs/
# Repo
# - https://github.com/starship/starship
#
set -euo pipefail
IFS=$'\n\t'

mkdir -p ~/.local/bin

curl -sS https://starship.rs/install.sh |
  sh -s -- --force --bin-dir ~/.local/bin
