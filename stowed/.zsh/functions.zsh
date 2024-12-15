#!/usr/bin/zsh

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

ycd() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Find Keycode
keycode () {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# cliphist interface
clip() {
  cliphist list | fzf --no-sort | cliphist decode | wl-copy
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
