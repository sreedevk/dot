{ pkgs, config, ... }:
let
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  home.file = {
    ".config/waybar/config" = {
      enable = true;
      text = builtins.toJSON
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
            "privacy"
            "custom/dnd"
            "custom/separator"
            "pulseaudio"
            "custom/separator"
            "wireplumber"
            "custom/separator"
            "custom/memory"
            "custom/separator"
            "custom/gpu"
            "custom/separator"
            "custom/cpu-temp"
            "custom/separator"
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
            format-ethernet = "󰀂  {ipaddr}";
            format-alt = "󱛇  {essid} {ipaddr}";
            format-disconnected = "󰖪";
            tooltip-format-wifi = "{icon} {essid}\n ";
            tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            interval = 5;
            nospacing = 1;
          };
          pulseaudio = {
            format = "{format_source}";
            format-source = "mic {volume}%";
            format-source-muted = "mic OFF";
          };
          privacy = {
            icon-spacing = 4;
            icon-size = 18;
            transition-duration = 250;
            modules = [
              {
                type = "screenshare";
                tooltip = true;
                tooltip-icon-size = 24;
              }
              {
                type = "audio-out";
                tooltip = true;
                tooltip-icon-size = 24;
              }
              {
                type = "audio-in";
                tooltip = true;
                tooltip-icon-size = 24;
              }
            ];
          };
          wireplumber = {
            format = "{icon}  {volume}%";
            format-bluetooth = "󰂰";
            nospacing = 1;
            tooltip = false;
            format-muted = "muted";
            format-icons = {
              headphone = "";
              default = [ "󰕿" "󰖀" "󰕾" "󰕾" "󰕾" ];
            };
            on-click = "pamixer -t";
            scroll-step = 1;
          };
          "custom/logo" = {
            format = " ";
            "tooltip" = false;
          };
          "custom/separator" = {
            format = " | ";
            "tooltip" = false;
          };
          "custom/memory" = {
            format = "󰘚  {}";
            exec = "${scripts.memory-script}/bin/memory";
            restart-interval = 5;
          };
          "custom/cpu-temp" = {
            format = "󰍛  {}";
            exec = "${scripts.cpu-temp-script}/bin/cpu-temp";
            restart-interval = 5;
          };
          "custom/gpu" = {
            format = "󰟽 {}";
            exec = "${scripts.gpu-script}/bin/gpu";
            restart-interval = 2;
          };
          "custom/dnd" = {
            format = "{}";
            exec = "${scripts.dnd-script}/bin/dnd";
            restart-interval = 2;
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
