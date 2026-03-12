function fish_user_key_bindings
    fish_vi_key_bindings

    bind -M insert ctrl-e accept-autosuggestion
    bind -M insert ctrl-a beginning-of-line
    bind -M insert ctrl-w backward-kill-word
end
