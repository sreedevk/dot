export HOME="/home/$USER"
export DATADIR="$HOME/data"
export PKGREPOS=$DATADIR/repositories

echo "##################################################"
echo "######## MANJARO POST INSTALLATION SCRIPT ########"
echo "##################################################"

echo "USER: $USER"
echo "HOME: $HOME"
echo "DATADIR: $DATADIR"
echo "Please ensure that you've installed nvidia drivers + xorg-server"

# install all official repository packages
pacman --needed --ask 4 -Sy - < "${0:a:h}/pkglist.txt"

# install AUR manager
mkdir -p "$PKGREPOS"
pacman --no-confirm -S --needed base-devel "$PKGREPOS"
git clone https://aur.archlinux.org/paru.git "$PKGREPOS"
cd "$PKGREPOS/paru" || exit
makepkg -si
cd "$HOME" || exit

# install all AUR packages
paru -S asciinema antibody community/brave-browser bumblebee-status-git 

# installing ASDF for development deps
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
