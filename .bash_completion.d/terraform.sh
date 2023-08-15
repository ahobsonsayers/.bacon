#!/usr/bin/env bash

if ! terraform=$(command -v terraform); then
  complete -C "$terraform" terraform
fi
