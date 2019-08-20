# GIT ALIASES
alias gst='git status'
alias gco='git checkout'
alias gitline='git log --pretty=oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias glog='git log'

# RAILS ALIASES

alias railss='rails s'
alias raisl='rails'
alias railsenv='echo $RAILS_ENV'
alias prodenv='export RAILS_ENV=production'
alias testenv='export RAILS_ENV=test'
alias devenv='export RAILS_ENV=development'
alias raisls='rails s'
alias railsext='rails s -b 0.0.0.0'
alias rc='rails c'

# SYSTEM ALIASES
alias cls='clear'
alias odir='nautilus --no-desktop . &'
alias reset_database='rake db:drop db:create db:migrate'
alias gnometheme='bash -c  "$(wget -qO- https://git.io/vQgMr)"'
alias spid='ps aux | grep'
alias ll='ls -alF --color="auto"'
alias la='ls -A --color="auto"'
alias l='ls -CF --color="auto"'
alias grep='grep --color="auto"'
alias ccat='highlight --out-format=ansi'

# INTERNET ALIASES
alias yt='youtube-dl --add-metadata -ic'   # download youtube video
alias yta='youtube-dl --add-metadata -xic' # download youtube audio

# PYTHON ALIASES
alias p3="python3"
alias python="python3"

# VIM ALIASES

alias vm='vi'
alias vim='nvim'
alias ivm='nvim'
alias nv='nvim'
alias vi='nvim'
alias pr='pull_request'


# EMACS
alias smacs="emacs -nw"
alias smac="emacs"

# PSQL

alias start_postgres="sudo pg_ctlcluster 11 main start"
