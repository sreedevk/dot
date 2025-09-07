{ pkgs, opts, ... }:
let
  hyprlock-status-script = pkgs.writeShellScriptBin "hyprlock-status" ''
    enable_battery=false
    battery_charging=false

    for battery in /sys/class/power_supply/*BAT*; do
      if [[ -f "$battery/uevent" ]]; then
        enable_battery=true
        if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
          battery_charging=true
        fi
        break
      fi
    done

    if [[ $enable_battery == true ]]; then
      if [[ $battery_charging == true ]]; then
        echo -n "(+) "
      fi
      echo -n "$(cat /sys/class/power_supply/*/capacity | head -1)"%
      if [[ $battery_charging == false ]]; then
        echo -n " remaining"
      fi
    fi

    echo ""
  '';
in
{
  home.file = {
    ".config/hypr/hyprlock.conf" = {
      enable = true;
      text = ''
        $entry_background_color = rgba(33333311)
        $entry_border_color = rgba(3B3B3B55)
        $entry_color = rgba(FFFFFFFF)
        $font_family = Iosevka Nerd Font
        $font_family_clock = Iosevka Nerd Font
        $font_material_symbols = Font Awesome 6 Free

        general {
          hide_cursor = false
          ignore_empty_input = false
        }

        auth {
          pam:enabled = true
          pam:module = hyprlock
          fingerprint:enabled = true 
          fingerprint:retry_delay = 250 
        }

        background {
            color = rgba(0D0D17FF)
            path = ${opts.directories.wallpapers}/${opts.desktop.wallpaper}
            blur_size = 5
            blur_passes = 4
        }

        input-field {
            monitor =
            size = 250, 50
            outline_thickness = 2
            dots_size = 0.1
            dots_spacing = 0.3
            outer_color = $entry_border_color
            inner_color = $entry_background_color
            font_color = $entry_color
            position = 0, 20
            halign = center
            valign = center
        }

        label { # Clock
            monitor =
            text = $TIME
            shadow_passes = 1
            shadow_boost = 0.5
            color = $text_color
            font_size = 65
            font_family = $font_family_clock

            position = 0, 300
            halign = center
            valign = center
        }
        label { # Greeting
            monitor =
            text = Welcome $USER
            shadow_passes = 1
            shadow_boost = 0.5
            color = $text_color
            font_size = 20
            font_family = $font_family

            position = 0, 240
            halign = center
            valign = center
        }
        label { # lock icon
            monitor =
            text = lock
            shadow_passes = 1
            shadow_boost = 0.5
            color = $text_color
            font_size = 21
            font_family = $font_material_symbols

            position = 0, 65
            halign = center
            valign = bottom
        }
        label { # "locked" text
            monitor =
            text = locked
            shadow_passes = 1
            shadow_boost = 0.5
            color = $text_color
            font_size = 14
            font_family = $font_family

            position = 0, 45
            halign = center
            valign = bottom
        }

        label { # Status
            monitor =
            text = cmd[update:5000] ${hyprlock-status-script}/bin/hyprlock-status
            shadow_passes = 1
            shadow_boost = 0.5
            color = $text_color
            font_size = 14
            font_family = $font_family

            position = 30, -30
            halign = left
            valign = top
        }
      '';
    };
  };
}
