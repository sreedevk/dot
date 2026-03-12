set fish_greeting

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.ghcup/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/bin

set -a XDG_DATA_DIRS $HOME/.nix-profile/share
set XDG_DATA_HOME $HOME/.local/share
set XDG_CONFIG_HOME $HOME/.config
set XDG_STATE_HOME $HOME/.local/state
set XDG_CACHE_HOME $HOME/.cache
set DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set TERM xterm-256color
set VISUAL nvim
set EDITOR nvim
set SUDO_EDITOR $EDITOR
set READER zathura
set TERMINAL alacritty
set BROWSER brave
set DOTFILES $HOME/.dot
set KEYTIMEOUT 1
set TERMINFO /usr/share/terminfo/
set MANROFFOPT -c
set -x MANPAGER "nvim +Man!"
set MANPATH $HOME/.nix-profile/share/man /usr/share/man /usr/local/share/man $MANPATH
set LANG en_US.UTF-8
set TZ America/New_York
set CLICOLOR 1

if status is-interactive
    echo && fastfetch && echo
end
