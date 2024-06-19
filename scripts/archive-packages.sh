#!/usr/bin/env zsh

set -xe 

pacman -Qe > ~/.dot/archlinux/packages.txt
cargo install --list | grep ':' | sed 's/://g' > ~/.dot/archlinux/cargo.txt
