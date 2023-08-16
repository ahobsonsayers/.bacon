#!/usr/bin/env bash
#
# Website:
# - https://asdf-vm.com/
# Repo
# - https://github.com/asdf-vm/asdf
#
set -euo pipefail
IFS=$'\n\t'

! [[ -d ~/.asdf ]] &&
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

~/.asdf/bin/asdf update
