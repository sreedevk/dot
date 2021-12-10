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
       hl-todo                         ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       (ligatures +extra)              ; ligatures and symbols to make your code pretty again
       ophints                         ; highlight the region an operation acts on
       (popup
        +all
        +defaults)                     ; tame sudden yet inevitable temporary windows
       treemacs                        ; a project drawer, like neotree but cooler
       unicode                         ; extended unicode support for various languages
       'vi-tilde-fringe                ; fringe tildes to mark beyond EOB
       (window-select +numbers)        ; visually switch windows
       workspaces                      ; tab emulation, persistence & separate workspaces
       ;; zen
       ;; hydra
       ;; minimap                      ; show a map of the code on the side
       ;; modeline                     ; snazzy, Atom-inspired modeline, plus API
       ;; vc-gutter                    ; vcs diff in the fringe
       ;; tabs                         ; a tab bar for Emacs
       ;; (emoji +unicode)
       ;; indent-guides                ; highlighted indent columns
       ;; doom-quit                    ; DOOM quit-message prompts when you quit Emacs

       :editor
       (evil +everywhere)              ; come to the dark side, we have cookies
       fold                            ; (nigh) universal code folding
       (format)                        ; automated prettiness
       word-wrap                       ; soft wrapping with language-aware indent
       ;; multiple-cursors             ; editing in many places at once
       ;; snippets                     ; my elves. They type so I don't have to
       ;; file-templates               ; auto-snippets for empty files

       :emacs
       dired                           ; making dired pretty [functional]
       electric                        ; smarter, keyword-based electric-indent
       ibuffer                         ; interactive buffer management
       undo                            ; persistent, smarter undo for your inevitable mistakes
       vc                              ; version-control and Emacs, sitting in a tree

       :term
       vterm                           ; the best terminal emulation in Emacs
       ;; eshell
       ;; shell
       ;; term

       :checkers
       (syntax +childframe)            ; tasing you for every semicolon you forget
       ;; spell
       ;; grammaer

       :tools
       direnv
       (eval +overlay)                  ; run code, run (also, repls)
       (lookup
        +dictionary
        +devdocs
        +docsets)        ; navigate your code and its documentation
       (magit +forge)    ; a git porcelain for Emacs
       upload            ; map local to remote projects via ssh/ftp
       tty               ; improve the terminal Emacs experience
       docker
       make           ; run make tasks from Emacs
       ;; gist           ; interacting with github gists
       ;; pass           ; password manager for nerds
       ;; pdf            ; pdf enhancements
       ;; rgb
       ;; taskrunner     ; taskrunner for all your projects
       ;; terraform      ; infrastructure as code
       ;; tmux           ; an API for interacting with tmux
       ;; ansible
       ;; debugger

       :lang
       assembly
       cc                ; C > C++ == 1
       crystal           ; ruby at the speed of c
       common-lisp
       data              ; config/data formats
       elixir            ; erlang done right
       emacs-lisp        ; drown in parentheses
       erlang            ; an elegant language for a more civilized age
       (go +lsp)
       (haskell +lsp)    ; a language that's lazier than I am
       json              ; At least it ain't XML
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       (julia +lsp)      ; a better, faster MATLAB
       (latex
        +latexmk
        +cdlatex
        +fold)           ; writing papers in Emacs has never been so fun
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
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
       python            ; beautiful is better than ugly
       purescript        ; javascript but functional
       qt             ; the 'cutest' gui framework ever
       (ruby             ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
        +rails)
       (rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       scala
       web               ; the tubes
       (yaml +lsp)       ; JSON, but readable
       ;; php            ; perl's insecure younger brother
       ;; (sh +lsp)         ; she sells {ba,z,fi}sh shells on the C xor
       ;; racket
       ;; raku
       ;; ocaml             ; an objective camel
       clojure
       ;; (ess +lsp)
       ;; elm               ; care for a cup of TEA?
       ;; kotlin
       ;; lsp

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
