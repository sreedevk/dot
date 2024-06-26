# TITLE: Zsh Functions
# AUTHOR: Sreedev Kodichath

# move files to trash instead of removing
trash () {
  mkdir -p /tmp/trash
  mv $1 /tmp/trash
}

# compile plugins after change in .zsh_plugins
antibody-compile () {
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

# Find Keycode
keycode () {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# APL Keyboard - Alt + Key
setxkbmap-apl () {
  setxkbmap -layout us,apl -variant ,dyalog -option grp:switch
}

cls () {
  echo "" | xclip -sel clip
  truncate -s0 $HOME/.cache/zsh/history
}

randstr() {
    local length=$1
    if [[ -z $length ]]; then
        echo "Usage: randstr <length>"
        return 1
    fi
    openssl rand -base64 $((length * 3 / 4)) | tr -d '\n' | cut -c1-$length
}

font () {
  alacritty msg config "font.size=$1"
}
