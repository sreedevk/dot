#!/usr/bin/zsh

# Find Keycode
keycode () {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# cliphist interface
clipman() {
  cliphist list | fzf --no-sort | cliphist decode | wl-copy
}

randstr() {
  local length=$1
  if [[ -z $length ]]; then
    echo "Usage: randstr <length>"
    return 1
  fi
  openssl rand -base64 $((length * 3 / 4)) | tr -d '\n' | cut -c1-$length
}

open() {
  xdg-open "$@" >/dev/null 2>&1
}
