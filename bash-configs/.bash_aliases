# GIT ALIASES
alias gst='git status'
alias gco='git checkout'
alias gitline='git log --pretty=oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias glog='git log'

# SYSTEM ALIASES
alias gnometheme='bash -c  "$(wget -qO- https://git.io/vQgMr)"'
alias ls='exa -lhr' # G -> grid

# INTERNET ALIASES
alias yt='youtube-dl --add-metadata -ic'   # download youtube video
alias yta='youtube-dl --add-metadata -xic' # download youtube audio

alias minecraft="java -jar ~/games/TLauncher-2.69.jar"
alias vlc_stream_screen="vlc --no-video-deco --no-embedded-video --screen-fps=60 --screen-top=32 --screen-left=0 --screen-width=1920 --screen-height=1000 screen://"

# ESP IDF
alias init_idf=". $HOME/esp/esp-idf/export.sh"
alias setup_idf="conda activate sys27 && init_idf"
