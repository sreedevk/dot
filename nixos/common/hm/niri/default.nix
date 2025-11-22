{
  pkgs,
  opts,
  config,
  ...
}:
{

  programs.niri = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.niri;
    settings = {

      spawn-at-startup = [
        {
          argv = [
            "dbus-update-activation-environment"
            "--systemd"
            "--all"
          ];
        }
        {
          argv = [
            "systemctl"
            "--systemd"
            "--all"
          ];
        }
        {
          argv = [
            "wl-paste"
            "--type"
            "image"
            "--watch"
            "cliphist"
            "store"
          ];
        }

        {
          argv = [
            "wl-paste"
            "--type"
            "text"
            "--watch"
            "cliphist"
            "store"
          ];
        }
        {
          argv = [
            "wlsunset"
            "-l"
            "40.7"
            "-L"
            "-73.9"
          ];
        }
        {
          argv = [
            "xrdb"
            "~/.Xresources"
          ];
        }
      ];

      window-rules = [
        {
          matches = [
            { title = "^(Open Folder)(.*)$"; }
          ];
          open-floating = true;
          open-focused = true;
        }
        {
          matches = [
            { title = "^(Select a File)(.*)$"; }
          ];
          open-floating = true;
          open-focused = true;
        }
      ];

      outputs = {
        "eDP-1" = {
          enable = true;
          name = "AU Optronics 0xF99A";
          position = {
            x = 0;
            y = 1080;
          };
          scale = 1;
          variable-refresh-rate = "on-demand";
          mode = {
            width = 1920;
            height = 1200;
            refresh = 60.0;
          };
        };
        "DP-3" = {
          enable = true;
          name = "XEC ES-24X3A 0x00000022";
          position = {
            x = 0;
            y = 0;
          };
          scale = 1;
          variable-refresh-rate = "on-demand";
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
        };
        "DP-2" = {
          enable = true;
          name = "LG Electronics LG Ultra HD 0x00073F78";
          position = {
            x = 1920;
            y = 0;
          };
          scale = 1.6;
          variable-refresh-rate = "on-demand";
          mode = {
            width = 3840;
            height = 2160;
            refresh = 60.0;
          };
        };
      };

      workspaces = {
      };

      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
        {
          XF86AudioLowerVolume.action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
          XF86AudioMicMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          XF86AudioMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          XF86AudioNext.action = spawn "${pkgs.playerctl}/bin/playerctl" "next";
          XF86AudioPause.action = spawn "${pkgs.playerctl}/bin/playerctl" "play-pause";
          XF86AudioPlay.action = spawn "${pkgs.playerctl}/bin/playerctl" "play-pause";
          XF86AudioPrev.action = spawn "${pkgs.playerctl}/bin/playerctl" "previous";
          XF86AudioRaiseVolume.action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";

          XF86MonBrightnessDown.action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%-";
          XF86MonBrightnessUp.action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%+";

          "Ctrl+Space".action = spawn "noctalia" "ipc" "call" "notifications" "dismissAll";
          "Ctrl+XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%-";
          "Ctrl+XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "Ctrl+XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%+";

          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+K".action = focus-workspace-up;
          "Mod+J".action = focus-workspace-down;

          "Mod+1".action = focus-monitor "DP-3";
          "Mod+2".action = focus-monitor "DP-2";
          "Mod+3".action = focus-monitor "eDP-1";

          "Mod+Ctrl+H".action = set-column-width "-10%";
          "Mod+Ctrl+L".action = set-column-width "+10%";

          "Mod+Shift+E".action = quit { skip-confirmation = true; };
          "Mod+Shift+H".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+L".action = move-column-right-or-to-monitor-right;

          "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+K".action = move-window-up-or-to-workspace-up;

          "Mod+Shift+Q".action = close-window;
          "Mod+F".action = toggle-windowed-fullscreen;

          "Mod+A".action = spawn "pwvucontrol";
          "Mod+C".action = spawn "noctalia" "ipc" "call" "controlCenter" "toggle";
          "Mod+D".action = spawn "${pkgs.rofi}/bin/rofi" "-show" "drun";
          "Mod+N".action = spawn "noctalia" "ipc" "call" "notifications" "toggleDND";
          "Mod+S".action = spawn "noctalia" "ipc" "call" "settings" "toggle";
          "Mod+W".action = spawn "noctalia" "ipc" "call" "wallpaper" "toggle";
          "Mod+O".action = toggle-overview;
          "Mod+Return".action = spawn "${config.programs.alacritty.package}/bin/alacritty";
          "Mod+Shift+Return".action = spawn "${config.programs.kitty.package}/bin/kitty";
          "Mod+KP_Enter".action = spawn "${config.programs.alacritty.package}/bin/alacritty";
          "Mod+XF86AudioLowerVolume".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%-";
          "Mod+XF86AudioRaiseVolume".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%+";
          "Mod+Shift+S".action = sh ''
            ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
          '';
        };
    };
  };
}
