{ pkgs, config, opts, ... }:
{
  home.file = {
    ".config/nsxiv/exec/key-handler" = {
      enable = true;
      executable = true;
      text = ''
        #!/bin/bash
        while read -r file; do
        	case "$1" in
        		"y") printf "%s" "$file" | tr -d '\n' | wl-copy && notify-send "$file copied to clipboard" & ;;
        		"d") [ "$(printf "No\nYes" | ${pkgs.wofi}/bin/wofi --dmenu -p "Really delete $file?")" = "Yes" ] && rm "$file" && notify-send "$file deleted" ;;
        		"D") rm -f "$file" && notify-send "$file deleted" ;;
        		"r") if type convert > /dev/null 2>&1; then convert -rotate 90 "$file" "$file"; else notify-send "Imagemagick is not installed!"; fi ;;
        		"R") if type convert > /dev/null 2>&1; then convert -rotate -90 "$file" "$file"; else notify-send "Imagemagick is not installed!"; fi ;;
        		"m") if type convert > /dev/null 2>&1; then convert -flop "$file" "$file"; else notify-send "Imagemagick is not installed!"; fi ;;
        		"e") if type gimp > /dev/null 2>&1; then setsid -f gimp "$file"; else notify-send "Gimp is not installed!"; fi ;;
            "l")
              name="$(${pkgs.wofi}/bin/wofi --dmenu -p "rename $file to: ")" 2> /dev/null
              if ! [ -z "$name" ]; then
                mv "$file" "$(dirname $file)/$name"
              fi
              ;;
        	esac
        done
      '';
    };
  };

}
