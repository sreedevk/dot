if status is-interactive
    if command -q starship
        starship init fish | source
    end

    if command -q direnv-instant
        direnv-instant hook fish | source
    end

    if command -q mise
        mise activate fish --shims | source
    end

    if command -q jj
        jj util completion fish | source
    end

    if command -q opam
        function __lazy_opam
            functions -e __lazy_opam ocaml ocamlopt ocamlfind dune opam
            opam env | source
        end

        for cmd in ocaml ocamlopt ocamlfind dune opam
            function $cmd --wraps=$cmd
                __lazy_opam
                command $cmd $argv
            end
        end
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
    end
end
