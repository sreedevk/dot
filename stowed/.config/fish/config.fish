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

set -gx FZF_DEFAULT_OPTS "--layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark"

status is-interactive; or exit

function fish_user_key_bindings
    fish_vi_key_bindings
end

bind -M insert ctrl-e accept-autosuggestion
bind -M insert ctrl-a beginning-of-line
bind -M insert ctrl-w backward-kill-word
bind -M insert -m default jj force-repaint

if command -q starship
    starship init fish | source
end

if command -q direnv
    direnv hook fish | source
end

if command -q mise
    mise activate fish | source
end

if command -q jj
    jj util completion fish | source
end

if command -q opam
    opam env | source
end

if command -q pueue
    pueue completions fish | source
end

if command -q just
    just --completions fish | source
end

if command -q docker
    docker completion fish | source
end

if command -q jira
    jira completion fish | source
end

if command -q rbw
    rbw gen-completions fish | source
end

if command -q rv
    rv shell init fish | source
    rv shell completions fish | source
end

if command -q zoxide
    zoxide init fish | source
end

abbr --add xo xdg-open
abbr --add clock tty-clock -csSbt -C3
abbr --add cw cliphist --wipe
abbr --add tt taskwarrior-tui
abbr --add tl tasklite
abbr --add obliterate shred -zvu -n 5
abbr --add mux tmuxinator
abbr --add t tmux new -A -s system
abbr --add ta tmux a
abbr --add ts tmux-sessionizer
abbr --add g git
abbr --add gg jj
abbr --add dc docker compose
abbr --add d docker
abbr --add yt yt-dlp
abbr --add zz zi
abbr --add jctl journalctl -p 3 -xb
abbr --add tb nc termbin.com 9999

alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

echo && fastfetch && echo
