;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       (company +childframe)           ; the ultimate code completion backend
       (vertico +icons)                ; the search engine of the future
       ivy                             ; a search engine for love and life

       :ui
       deft                            ; notes
       doom                            ; what makes DOOM look the way it does
       doom-dashboard                  ; a nifty splash screen for Emacs
       ;; doom-quit                    ; DOOM quit-message prompts when you quit Emacs
       hl-todo                         ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;; (emoji +unicode)
       ;; indent-guides                ; highlighted indent columns
       (ligatures +extra)              ; ligatures and symbols to make your code pretty again
       ;; minimap                      ; show a map of the code on the side
       modeline                        ; snazzy, Atom-inspired modeline, plus API
       ophints                         ; highlight the region an operation acts on
       (popup
        +all
        +defaults)                     ; tame sudden yet inevitable temporary windows
       ;; tabs                         ; a tab bar for Emacs
       treemacs                        ; a project drawer, like neotree but cooler
       unicode                         ; extended unicode support for various languages
       ;; vc-gutter                    ; vcs diff in the fringe
       'vi-tilde-fringe                ; fringe tildes to mark beyond EOB
       (window-select +numbers)        ; visually switch windows
       workspaces                      ; tab emulation, persistence & separate workspaces
       ;; zen
       ;; hydra

       :editor
       (evil +everywhere)              ; come to the dark side, we have cookies
       ;; file-templates                  ; auto-snippets for empty files
       ;; fold                            ; (nigh) universal code folding
       (format)                        ; automated prettiness
       ;; multiple-cursors             ; editing in many places at once
       ;; snippets                     ; my elves. They type so I don't have to
       ;; word-wrap                    ; soft wrapping with language-aware indent

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       ibuffer           ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ;; eshell
       ;; shell
       ;; term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe) ; tasing you for every semicolon you forget
       ;; spell
       ;; grammaer

       :tools
       ;; ansible
       ;; debugger
       direnv
       ;; docker
       (eval +overlay)   ; run code, run (also, repls)
       ;; gist           ; interacting with github gists
       (lookup
        +dictionary
        +devdocs
        +docsets)        ; navigate your code and its documentation
       (magit +forge)    ; a git porcelain for Emacs
       ;; make           ; run make tasks from Emacs
       ;; pass           ; password manager for nerds
       pdf               ; pdf enhancements
       rgb
       ;; taskrunner     ; taskrunner for all your projects
       ;; terraform      ; infrastructure as code
       ;; tmux           ; an API for interacting with tmux
       upload            ; map local to remote projects via ssh/ftp
       tty               ; improve the terminal Emacs experience

       :lang
       assembly
       cc                ; C > C++ == 1
       crystal           ; ruby at the speed of c
       common-lisp
       clojure
       data              ; config/data formats
       elixir            ; erlang done right
       elm               ; care for a cup of TEA?
       emacs-lisp        ; drown in parentheses
       (ess +lsp)
       erlang            ; an elegant language for a more civilized age
       (go +lsp)
       (haskell +lsp)    ; a language that's lazier than I am
       json              ; At least it ain't XML
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       (julia +lsp)             ; a better, faster MATLAB
       ;; kotlin
       lsp
       (latex
        +latexmk
        +cdlatex
        +fold)           ; writing papers in Emacs has never been so fun
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ocaml             ; an objective camel
       (org
        +roam2
        +brain
        +dragndrop       ; drag n drop images into orgs
        +pretty          ; unicode symbols
        +present         ; presentation
        ;; +hugo         ; hugo blogging
        +gnuplot
        ;; +pandoc
        +journal)        ; organize your plain life in plain text
       ;; php            ; perl's insecure younger brother
       python            ; beautiful is better than ugly
       purescript        ; javascript but functional
       ;; qt             ; the 'cutest' gui framework ever
       (ruby             ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
        ;;+rails
        )
       (rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       racket
       raku
       scala
       (sh +lsp)         ; she sells {ba,z,fi}sh shells on the C xor
       web               ; the tubes
       (yaml +lsp)       ; JSON, but readable

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;; (wanderlust +gmail)

       :app
       calendar
       ;; everywhere        ; *leave* Emacs!? You must be joking
       irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader

       :config
       (default +bindings +smartparens))
