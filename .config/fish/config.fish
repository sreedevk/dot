if status is-interactive
    # DISABLE FISH GREETINGS
    set fish_greeting

    # TERMINAL
    set TERM "xterm-256color"

    # SET BAT AS MAN PAGES CLIENT
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

    # SET VI KEYBINDINGS
    fish_vi_key_bindings

    # SET EMACS KEYBINDINGS (DEFAULT)
    # fish_default_key_bindings

    # SYNTAX HIGHLIGHTS
    set fish_color_autosuggestion '#7d7d7d'
    set fish_color_param brcyan
    set fish_color_normal brcyan
    set fish_color_command brcyan
    set fish_color_error '#ff6c6b'


end
