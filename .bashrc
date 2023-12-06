#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091
export USER=$(id -un)

# configure bash behavior
shopt -s expand_aliases

function error() {
  local red="\033[31m"
  local reset="\033[0m"
  echo -e "$red$*$reset" >&2
}

function check_installed() {
  command -v "$1" &>/dev/null
}

# Prompt customisation
[[ -r ~/.bash_prompt ]] &&
  source ~/.bash_prompt

# Alias definitions
[[ -r ~/.bash_aliases ]] &&
  source ~/.bash_aliases

# Scripts
[[ -r ~/scripts/scripts.sh ]] && 
  source ~/scripts/scripts.sh

# homebrew
[[ -d /home/linuxbrew/.linuxbrew ]] &&
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[[ -d /opt/homebrew ]] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

# asdf
[[ -r ~/.asdf/asdf.sh ]] &&
  source ~/.asdf/asdf.sh

# Add user bin to path
# After brew & asdf so it takes priority
user_bin="$HOME/bin"
[[ -d $user_bin ]] &&
  PATH="$user_bin:$PATH"

# Add user local bin to path
# After brew & asdf so it takes priority
user_local_bin="$HOME/.local/bin"
[[ -d $user_local_bin ]] &&
  PATH="$user_local_bin:$PATH"

# ble.sh
[[ -r ~/.local/share/blesh/ble.sh ]] &&
  [[ $BLE_ATTACHED != 1 ]] &&
  source ~/.local/share/blesh/ble.sh

# starship
if check_installed starship; then
  eval "$(starship init bash)"
fi

# go
if check_installed go; then
  go_path=$(go env GOPATH)
  export PATH="${go_path}/bin:$PATH"
fi

# perl
if [[ -d ~/perl5 ]]; then
  export PATH="$HOME/perl5/bin:$PATH"
  export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
  export PERL_LOCAL_LIB_ROOT="$HOME/perl5:$PERL_LOCAL_LIB_ROOT"
fi

# completions
if [[ -r /etc/bash_completion ]]; then
  source /etc/bash_completion
elif [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
  source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

# local configuration
[[ -r ~/.bash_local ]] &&
  source ~/.bash_local
