{ pkgs, ... }:
let
  modules = {
    memory = import ./modules/memory.nix { inherit pkgs; };
    gpu    = import ./modules/gpu.nix { inherit pkgs; };
    dnd    = import ./modules/dnd.nix { inherit pkgs; };
  };
in
{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 38;
        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
        ];
        "modules-center" = [
          "privacy"
          "custom/dnd"
          "custom/separator"
          "pulseaudio"
          "wireplumber"
          "custom/separator"
          "custom/memory"
          "custom/separator"
          "custom/gpu"
          "custom/separator"
          "temperature"
          "cpu"
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
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
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
          format-source = "∿ {volume}%";
          format-source-muted = "─ OFF";
        };
        privacy = {
          icon-spacing = 12;
          icon-size = 16;
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
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
              "󰕾"
              "󰕾"
            ];
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
          exec = "${modules.memory}/bin/memory";
          restart-interval = 5;
        };
        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = "󰍛  {temperatureC}°C";
        };
        cpu = {
          format = " {avg_frequency}G";
          interval = 2;
        };
        "custom/gpu" = {
          format = "󰟽 {}";
          exec = "${modules.gpu}/bin/gpu";
          restart-interval = 2;
        };
        "custom/dnd" = {
          format = "{}";
          exec = "${modules.dnd}/bin/dnd";
          restart-interval = 2;
        };
        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            "default" = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
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
