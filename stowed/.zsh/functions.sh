# TITLE: Zsh Functions
# AUTHOR: Sreedev Kodichath

# move files to trash instead of removing
trash(){
  mkdir -p /tmp/trash
  mv $1 /tmp/trash
}

# compile plugins after change in .zsh_plugins
antibody-compile(){
  antibody bundle < ~/.zsh/plugins > ~/.zsh/plugins.sh
}

# change directories in style
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# ix.io pastebin
ix() {
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
        case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
        esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] && {
        local filename="$1"
        shift
        [ "$filename" ] && {
            curl $opts -F f:1=@"$filename" $* ix.io/$id
            return
        }
        echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}

# Find Keycode
keycode() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# disable NMI Watchdog
disable_nmi_watchdog() {
  sudo sysctl kernel.nmi_watchdog=0
}

# APL Keyboard - Alt + Key
init-apl() {
  setxkbmap -layout us,apl -variant ,dyalog -option grp:switch
}
