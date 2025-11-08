{ pkgs
, lib
, ...
}:
{

  home.packages = with pkgs; [ nsxiv ];
  home.file = {
    ".config/nsxiv/exec/key-handler" = {
      enable = true;
      executable = true;
      text = ''
        #!/bin/bash

        detect-session() {
          if [ "$XDG_SESSION_TYPE" = "wayland" ] || [ -n "WAYLAND_DISPLAY" ]; then
            printf '%s' wayland
          elif [ "$XDG_SESSION_TYPE" = "x11" ] || [ -n "$DISPLAY" ]; then
            printf '%s' x11
          else
            printf '%s' unknown
          fi
        }

        copy-filepath-to-clipboard() {
          local filepath="$1"
          local session="$(detect-session)"
          case "$session" in
            wayland)
              printf "%s" "$filepath" | tr -d '\n' | wl-copy && \
              notify-send "$filepath copied to clipboard" ;; 
            x11)
              printf "%s" "$filepath" | tr -d '\n' | xclip -sel clip && \
              notify-send "$filepath copied to clipboard" ;;
            *)
              notify-send "error: desktop session unrecognized" ;;
          esac
        }

        delete-file-after-confirm() {
          local filepath="$1"
          [ "$(printf "no\nyes" | ${pkgs.wofi}/bin/wofi --dmenu -p "delete $filepath?")" = "yes" ] && \
          rm "$filepath" && \
          notify-send "$filepath deleted"
        }

        force-delete-file() {
          local filepath="$1"
          rm -f "$filepath" && notify-send "$filepath deleted"
        }

        rotate-cw() {
          local filepath="$1"
          if type magick > /dev/null 2>&1; then 
            magick convert -rotate 90 "$filepath" "$filepath"
          else 
            notify-send "imagemagick is not installed!" 
          fi
        }

        rotate-ccw() {
          local filepath="$1"
          if type magick > /dev/null 2>&1; then 
            magick convert -rotate -90 "$filepath" "$filepath"
          else
            notify-send "imagemagick is not installed!"
          fi
        }

        flip-horizontal() {
          local filepath="$1"
          if type magick > /dev/null 2>&1; then 
            magick convert -flop "$filepath" "$filepath" 
          else 
            notify-send "imagemagick is not installed!"
          fi
        }

        open-in-gimp() {
          local filepath="$1"
          if type gimp > /dev/null 2>&1; then 
            setsid -f gimp "$filepath"
          else 
            notify-send "Gimp is not installed!"
          fi
        }

        rename-file() {
          local filepath="$1"
          name="$(${pkgs.wofi}/bin/wofi --dmenu -p "rename $filepath to: ")" 2> /dev/null
          if ! [ -z "$name" ]; then
            mv "$filepath" "$(dirname $filepath)/$name"
          fi
        }

        set-as-wallpaper() {
          local filepath="$1"
          local session="$(detect-session)"
          case "$session" in
            wayland)
              noctalia ipc call wallpaper set "$filepath" all
              notify-send "wallpaper set to: $filepath" ;;
            x11)
              ${pkgs.feh} --bg-scale "$filepath"
              notify-send "$file set as wallpaper" ;;
            *)
              notify-send "couldn't set wallpaper: unknown desktop server" ;;
          esac
        }

        while read -r file; do
        	case "$1" in
        		"y") copy-filepath-to-clipboard $file & ;;
        		"d") delete-file-after-confirm $file ;;
        		"D") force-delete-file $file ;;
        		"r") rotate-cw $file ;;
        		"R") rotate-ccw $file ;;
        		"m") flip-horizontal $file ;;
        		"e") open-in-gimp $file ;;
            "l") rename-file $file ;;
            "w") set-as-wallpaper $file ;;
        	esac
        done
      '';
    };
  };

  xresources.properties = {
    "Nsxiv.background" = lib.mkForce "#141c21";
    "Nsxiv.font" = lib.mkForce "DejaVu Sans-14";
    "Nsxiv.foreground" = lib.mkForce "#1f1d2e";
  };

  xdg.desktopEntries = {
    nsxiv = {
      name = "Neo Simple X Image Viewer";
      icon = "nsxiv";
      genericName = "Image viewer";
      exec = "${pkgs.nsxiv}/bin/nsxiv %F";
      comment = "Image Viewer & Cataloguer";
      mimeType = [
        "image/bmp"
        "image/gif"
        "image/heic"
        "image/jpeg"
        "image/jpg"
        "image/pjpeg"
        "image/png"
        "image/tiff"
        "image/webp"
        "image/x-bmp"
        "image/x-pcx"
        "image/x-png"
        "image/x-portable-anymap"
        "image/x-portable-bitmap"
        "image/x-portable-graymap"
        "image/x-portable-pixmap"
        "image/x-tga"
        "image/x-xbitmap"
        "image/x-xcf"
      ];
      terminal = false;
      type = "Application";
      categories = [
        "Graphics"
        "2DGraphics"
        "Viewer"
      ];
    };
  };
}
