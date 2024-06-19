#!/usr/bin/env zsh

set -xe 

pacman -S - < ~/.dot/archlinux/packages.txt
cat ~/.dot/archlinux/cargo.txt | awk '{print $1}' | xargs -Ix cargo install x
