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
export PKGREPOS=$DATADIR/repositories

echo "##################################################"
echo "######## MANJARO POST INSTALLATION SCRIPT ########"
echo "##################################################"

echo "DO NOT RUN THE SCRIPT WITH SUDO. SUDO WILL BE INVOKED WHEN REQUIRED."

echo "USER: $USER"
echo "HOME: $HOME"
echo "DATADIR: $DATADIR"

# install AUR manager
mkdir -p "$PKGREPOS"
sudo pacman --noconfirm -S --needed base-devel
git clone https://aur.archlinux.org/paru.git "$PKGREPOS/paru"
cd "$PKGREPOS/paru" || exit
makepkg -si
cd "$HOME" || exit

# Setup Dotfiles
sudo pacman --noconfirm -Syy stow
git clone https://github.com/sreedevk/dot $HOME/.dot
stow --adopt $HOME/.dot/stowed/

# Installing Language Dependencies + ASDF
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1
asdf plugin add nodejs
asdf install

# Zsh Installation + Dependencies
sudo pacman --noconfirm -Syy zsh starship
paru --noconfirm -S antibody
antibody bundle < $HOME/.zsh/.zsh_plugins > $HOME/.zsh/.zsh_plugins.sh

# Installing Emacs + Chemacs + Doom Emacs
sudo pacman --noconfirm -Syy emacs
git clone https://github.com/plexus/chemacs2.git $HOME/.emacs.d
$HOME/.emacs-distros/doom-emacs/bin/doom install


# Installing Neovim + Packer + Deps
sudo pacman --noconfirm -Syy neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless +PackerInstall +q
