if status is-interactive
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
        function __lazy_zoxide
            functions -e __lazy_zoxide z zi
            zoxide init fish | source
        end

        function z
            __lazy_zoxide
            __zoxide_z $argv
        end

        function zi
            __lazy_zoxide
            __zoxide_zi $argv
        end

        zoxide init fish | source
    end

    # Enables the following keybindings:
    # CTRL-t = fzf select
    # CTRL-r = fzf history
    # ALT-c  = fzf cd
    if command -q fzf
        fzf --fish | source
    end

end
