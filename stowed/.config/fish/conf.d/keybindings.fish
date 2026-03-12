function __ce_accept_or_eol
    commandline -f accept-autosuggestion
    commandline -f end-of-line
end

function fish_user_key_bindings
    fish_vi_key_bindings

    bind -M insert ctrl-e accept-autosuggestion
    bind -M insert ctrl-a beginning-of-line
    bind -M insert ctrl-w backward-kill-word
    bind -M insert ctrl-e __ce_accept_or_eol
    bind -M normal A end-of-line
end
