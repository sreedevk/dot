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
       (ligatures +extra)
       modeline
       neotree
       ophints
       (popup +defaults)
       tabs
       treemacs
       unicode
       (vc-gutter +pretty)
       vi-tilde-fringe
       window-select
       workspaces

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

       :checkers
       syntax
       (spell +flyspell)

       :tools
       debugger
       direnv
       docker
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
       javascript
       julia
       ;;kotlin
       latex
       ;;lean
       ;;ledger
       lua
       markdown
       ;;nim
       ;;nix
       ocaml
       (org
        +roam2
        +brain
        +dragndrop
        +pretty
        +present
        +hugo
        +gnuplot
        +pandoc
        +journal)
       ;;php
       ;;purescript
       python
       ;;qt
       ;;racket
       ;;rak
       ;;rest
       ;;rst
       (ruby +rails)
       (rust +lsp)
       scala
       (scheme +guile)
       sh
       ;;solidity
       ;;swift
       ;;terra
       web
       yaml
       zig

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       ;;emms
       ;;everywhere
       ;;irc
       ;;(rss +org)
       ;;twitter

       :config
       (default +bindings +smartparens))
