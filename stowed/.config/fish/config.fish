set fish_greeting

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.ghcup/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/bin

set -a XDG_DATA_DIRS $HOME/.nix-profile/share
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -gx TERM xterm-256color
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx SUDO_EDITOR $EDITOR
set -gx READER zathura
set -gx TERMINAL kitty
set -gx BROWSER brave
set -gx DOTFILES $HOME/.dot
set -gx KEYTIMEOUT 1
set -gx TERMINFO /usr/share/terminfo/
set -gx MANROFFOPT -c
set -gx MANPAGER "nvim +Man!"
set MANPATH $HOME/.nix-profile/share/man /usr/share/man /usr/local/share/man $MANPATH
set -gx LANG en_US.UTF-8
set -gx TZ America/New_York
set -gx CLICOLOR 1

if status is-interactive
    fzf_configure_bindings --directory=\cf --history=\cr --processes=\cp --variables=\cv
    set fzf_history_opts --with-nth=4..
    set fzf_preview_dir_cmd eza --all --color=always

    if command -q fastfetch
      echo && fastfetch && echo
    end
end
