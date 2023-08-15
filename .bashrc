#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

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

# Load functions
for function in ~/functions/*; do
    [ -f "$function" ] &&
        source "$function"
done

# homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    error "brew is not installed"
fi

# asdf
if [[ -r ~/.asdf/asdf.sh ]]; then
    source ~/.asdf/asdf.sh
else
    error "asdf is not installed"
fi

# Add user bin to path
# After brew & asdf so it takes priority
user_bin="$HOME/bin"
[[ -d "$user_bin" ]] &&
    PATH="$user_bin:$PATH"

# Add user local bin to path
# After brew & asdf so it takes priority
user_local_bin="$HOME/.local/bin"
[[ -d "$user_local_bin" ]] &&
    PATH="$user_local_bin:$PATH"

# starship
if check_installed starship; then
    eval "$(starship init bash)"
else
    error "starship is not installed"
fi

# go
if check_installed go; then
    go_path=$(go env GOPATH)
    export PATH="${go_path}/bin:$PATH"
fi

# Completions
if [ -r /etc/bash_completion ]; then
    source /etc/bash_completion
elif [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
    source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
else
    error "bash completions is not installed"
fi
