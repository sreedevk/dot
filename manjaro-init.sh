export HOME="/home/$USER"
export DATADIR="$HOME/data"
export PKGREPOS=$DATADIR/repositories

echo "USER: $USER"
echo "HOME: $USER"
echo "DATADIR: $USER"

echo "Please ensure that you've installed nvidia drivers + xorg-server"

# install all official repository packages
pacman --no-confirm -S arandr git curl zsh zsh-completions aws-cli boost boost-libs chromium clang cmake neovim emacs docker gawk gimp httpie hyperfine neofetch openssh rg fd 

# install AUR manager
mkdir -p $PKGREPOS
pacman --no-confirm -S --needed base-devel $PKGREPOS
git clone https://aur.archlinux.org/paru.git $PKGREPOS
cd $PKGREPOS/paru
makepkg -si
cd $HOME

# installing additional package manager
git clone https://aur.archlinux.org/aura-bin.git $PKGREPOS
cd $PKGREPOS/aura-bin
makepkg
pacman -U aura*.tar.xz

# install all AUR packages
paru -S asciinema antibody community/brave-browser bumblebee-status-git 

# installing ASDF for development deps
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
