#!/usr/bin/zsh

ycd() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f "$tmp" > /dev/null 2>&1
}

# Find Keycode
keycode () {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# cliphist interface
clip() {
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
