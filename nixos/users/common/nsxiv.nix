{ pkgs, lib, ... }:
{

  home.packages = with pkgs; [ nsxiv ];
  home.file = {
    ".config/nsxiv/exec/key-handler" = {
      enable = true;
      executable = true;
      text = ''
        #!/bin/bash

        if [ "$XDG_SESSION_TYPE" = "wayland" ] || [ -n "WAYLAND_DISPLAY" ]; then
          session="wayland"
        elif [ "$XDG_SESSION_TYPE" = "x11" ] || [ -n "$DISPLAY" ]; then
          session="x11"
        else
          session="unknown"
        fi

        copy-filepath-to-clipboard() {
          local filepath="$1"
          printf "%s" "$filepath" | tr -d '\n' | wl-copy && \
          notify-send "$filepath copied to clipboard"
        }

        delete-file-after-confirm() {
          local filepath="$1"
          [ "$(printf "No\nYes" | ${pkgs.wofi}/bin/wofi --dmenu -p "Really delete $filepath?")" = "Yes" ] && \
          rm "$filepath" && \
          notify-send "$filepath deleted"
        }

        force-delete-file() {
          local filepath="$1"
          rm -f "$filepath" && notify-send "$filepath deleted"
        }

        rotate-cw() {
          local filepath="$1"
          if type convert > /dev/null 2>&1; then 
            convert -rotate 90 "$filepath" "$filepath"
          else 
            notify-send "Imagemagick is not installed!" 
          fi
        }

        rotate-ccw() {
          local filepath="$1"
          if type convert > /dev/null 2>&1; then 
            convert -rotate -90 "$filepath" "$filepath"
          else
            notify-send "Imagemagick is not installed!"
          fi
        }

        flip-horizontal() {
          local filepath="$1"
          if type convert > /dev/null 2>&1; then 
            convert -flop "$filepath" "$filepath" 
          else 
            notify-send "Imagemagick is not installed!"
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
          case "$session" in
            wayland)
              ${pkgs.swww}/bin/swww img --transition-type wipe --transition-fps 60 --resize stretch --transition-step 60 --transition-duration 2 "$filepath"
              notify-send "wallpaper set to: $filepath"
              ;;
            x11)
              notify-send "x11 wallpaper setting is not supported"
              ;;
            *)
              notify-send "unknown desktop server"
              ;;
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
      categories = [ "Graphics" "2DGraphics" "Viewer" ];
    };
  };
}
