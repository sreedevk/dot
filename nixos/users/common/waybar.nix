{ pkgs, config, ... }:
let
  dnd-script =
    pkgs.writeShellScriptBin "dnd" ''
      [[ "$(${pkgs.dunst}/bin/dunstctl is-paused)" == "true" ]] && echo " " || echo " "
    '';
in
{
  home.file = {
    ".config/waybar/config" = {
      enable = true;
      source = builtins.toJSON
        {
          layer = "top";
          position = "top";
          spacing = 0;
          height = 34;
          modules-left = [
            "custom/logo"
            "hyprland/workspaces"
          ];
          "modules-center" = [
            "custom/dnd"
            "wireplumber"
            "custom/memory"
            "custom/gpu"
            "custom/cpu-temp"
            "network"
          ];
          "modules-right" = [
            "clock"
            "battery"
            "tray"
          ];
          "wlr/taskbar" = {
            format = "{icon}";
            on-click = "activate";
            on-click-right = "fullscreen";
            icon-theme = "WhiteSur";
            icon-size = 25;
            tooltip-format = "{title}";
          };
          "hyprland/workspaces" = {
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              "default" = "";
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
            };
            persistent_workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
            };
          };
          tray = {
            "spacing" = 10;
          };
          "clock" = {
            format = "  {:%a %B %d  %I:%M:%S %p %Z}";
            interval = 1;
          };
          network = {
            format-wifi = "{icon}";
            format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
            format-ethernet = "󰀂";
            format-alt = "󱛇";
            format-disconnected = "󰖪";
            tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            interval = 5;
            nospacing = 1;
          };
          wireplumber = {
            format = "{icon}";
            format-bluetooth = "󰂰";
            nospacing = 1;
            tooltip-format = "Volume : {volume}%";
            format-muted = "󰝟";
            format-icons = {
              headphone = "";
              default = [
                "󰖀"
                "󰕾"
                ""
              ];
            };
            on-click = "pamixer -t";
            scroll-step = 1;
          };
          "custom/logo" = {
            format = "  ";
            "tooltip" = false;
          };
          "custom/memory" = {
            format = "󰘚  {}";
            exec = "~/.config/waybar/blocks/memory.sh";
            restart-interval = 5;
          };
          "custom/cpu-temp" = {
            format = "󰍛  {}";
            exec = "~/.config/waybar/blocks/cpu-temp.sh";
            restart-interval = 5;
          };
          "custom/gpu" = {
            format = "󰟽 {}";
            exec = "~/.config/waybar/blocks/gpu.sh";
            restart-interval = 2;
          };
          "custom/dnd" = {
            format = "{}";
            exec = "${dnd-script}/bin/dnd";
            restart-interval = 5;
          };
          "battery" = {
            format = "{capacity}% {icon}";
            format-icons = {
              charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
              "default" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            };
            format-full = "";
            interval = 5;
            states = {
              warning = 20;
              critical = 10;
            };
            tooltip = false;
          };
        };
    };
  };
}
