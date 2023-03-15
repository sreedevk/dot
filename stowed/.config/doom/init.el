(doom! :input
       ;; bidi
       ;; chinese
       ;; japanese

       :completion
       (company +auto)
       (vertico +icons)

       :ui
       deft
       doom
       doom-dashboard
       hl-todo
       (ligatures +extra +fira +hasklig +iosevka +pragmata-pro)
       modeline
       minimap
       neotree
       ophints
       (popup +all +defaults)
       tabs
       (treemacs +lsp)
       unicode
       (vc-gutter +pretty)
       vi-tilde-fringe
       window-select
       workspaces
       zen

       :editor
       (evil
        +everywhere
        +commands)
       file-templates
       fold
       (format +onsave)
       lispy
       multiple-cursors
       rotate-text
       snippets
       word-wrap

       :emacs
       (dired
        +ranger
        +icons)
       electric
       ibuffer
       undo
       vc

       :term
       eshell
       vterm
       term
       shell

       :checkers
       syntax
       (spell +flyspell)

       :tools
       debugger
       direnv
       (docker +lsp)
       editorconfig
       (eval +overlay)
       gist
       lookup
       lsp
       magit
       make
       pdf
       rgb
       taskrunner
       tmux
       tree-sitter
       upload
       (pass +auth)

       :os
       (:if IS-MAC macos)
       tty

       :lang
       (cc +lsp)
       clojure
       common-lisp
       crystal
       data
       ;;(dart +flutter)
       elixir
       elm
       emacs-lisp
       erlang
       ;;fsharp
       ;; fstar
       (go +lsp)
       (graphql +lsp)
       (haskell +lsp)
       json
       (java +lsp)
       (javascript +lsp)
       (julia +lsp)
       ;;kotlin
       (latex +latexmk +cdlatex +fold +lsp)
       ;;lean
       ;;ledger
       (lua +fennel +moonscript)
       (markdown +grip)
       ;;nim
       ;;nix
       (ocaml +lsp)
       (org
        +roam
        +pretty
        +present
        +gnuplot
        +pandoc
        +journal)
       ;;php
       (purescript +lsp)
       python
       ;;qt
       ;;racket
       ;;rak
       ;;rest
       ;;rst
       (ruby +lsp +rails)
       (rust +lsp)
       ;; scala
       (scheme +guile)
       sml
       (sh +lsp)
       ;;solidity
       ;;swift
       ;;terra
       (web +lsp)
       yaml
       (zig +lsp)

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       ;;emms
       ;;everywhere
       ;;irc
       (rss +org)
       twitter

       :config
       (default +bindings +smartparens))
