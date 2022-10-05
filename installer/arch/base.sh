#!/usr/bin/sh

# Copyright 2021 (c) Sreedev Kodichath

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, 
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copiesor substantial
# portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

export HOME="/home/$USER"
export DATADIR="$HOME/data"
export PKGREPOS="$DATADIR/repositories"

echo "/__   \ |__   ___     /   \___ | |_    / _ \_ __ ___ (_) ___  ___| |_  "
echo "  / /\/ '_ \ / _ \   / /\ / _ \| __|  / /_)/ '__/ _ \| |/ _ \/ __| __| "
echo " / /  | | | |  __/  / /_// (_) | |_  / ___/| | | (_) | |  __/ (__| |_  "
echo " \/   |_| |_|\___| /___,' \___/ \__| \/    |_|  \___// |\___|\___|\__| "
echo "                                                    |__/               "

echo "DO NOT RUN THE SCRIPT WITH SUDO. SUDO WILL BE INVOKED WHEN REQUIRED."

echo "USER: $USER"
echo "HOME: $HOME"
echo "DATADIR: $DATADIR"

# BASE SETUP
echo "PACMAN INSTALL: base-devel openssh stow zsh starship neovim tmux"
sudo pacman --noconfirm -Syy --needed \
  base-devel openssh stow zsh starship neovim tmux

# AUR PACKAGE MANAGER SETUP
echo "INSTALLING AUR PACKAGE MANAGER PARU"
mkdir -p "$PKGREPOS"
rm -rf "$PKGREPOS/paru"
git clone https://aur.archlinux.org/paru.git "$PKGREPOS/paru"
cd "$PKGREPOS/paru" || exit
makepkg -si
cd "$HOME" || exit

# ASDF SETUP
echo "INSTALLING ASDF MULTI VERSION MANAGER"
rm -rf "$HOME/.asdf"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
asdf plugin add nodejs
asdf install

# ZSH SETUP
echo "INSTALLING ANTIBODY - ZSH PLUGIN MANAGER"
paru --noconfirm -S antibody
antibody bundle < $HOME/.zsh/.zsh_plugins > $HOME/.zsh/.zsh_plugins.sh

# NEOVIM SETUP
echo "INSTALL NEOVIM PLUGIN MANAGER - PACKER"
mkdir -p "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
rm -rf "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
git clone --depth 1 https://github.com/wbthomason/packer.nvim "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
nvim +PackerInstall +q

# TMUX SETUP
echo "INSTALLING TMUX PLUGIN MANAGER"
paru --noconfirm -S tmux-plugin-manager
rm -rf "$HOME/.tmux"
tmux source "$HOME/.tmux.conf"
