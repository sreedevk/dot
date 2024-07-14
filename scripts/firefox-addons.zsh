#!/usr/bin/env zsh

fflake=$(nix flake metadata ./nixos --json | jq '.locks.nodes."firefox-addons".original')
fdirectory=$(echo $fflake | jq '.dir' -r)
fowner=$(echo $fflake | jq '.owner' -r)
frepo=$(echo $fflake | jq '.repo' -r)
ftype=$(echo $fflake | jq '.type' -r)

nix flake show "${ftype}:${fowner}/${frepo}?dir=${fdirectory}" --json | jq -r '.packages."x86_64-linux".[].name' | fzf
