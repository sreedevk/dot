# TITLE: Fish (Friendly Interactive Shell) Configuration
# AUTHOR: Sreedev Kodichath

if status is-interactive
    set fish_greeting
    set TERM "xterm-256color"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    fish_vi_key_bindings

    set fish_color_autosuggestion '#7d7d7d'
    set fish_color_param brcyan
    set fish_color_normal brcyan
    set fish_color_command brcyan
    set fish_color_error '#ff6c6b'
end
