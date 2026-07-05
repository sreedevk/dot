{
  pkgs,
  opts,
  config,
  ...
}:
let
  niri = pkgs.lib.getExe (
    pkgs.writeShellScriptBin "niri-instance" ''
      ${pkgs.niri}/bin/niri --session
    ''
  );
in
{

  home.file = {
    ".profile" = {
      enable = true;
      recursive = false;
      target = ".profile";
      executable = true;
      text = ''
        export XDG_DATA_DIRS="${config.home.profileDirectory}/share:/usr/local/share:/usr/share"

        if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        fi

        if uwsm check may-start > /dev/null 2>&1; then
          exec uwsm start ${niri}
        fi
      '';
    };

    ".config/uwsm/env-niri" = {
      enable = true;
      executable = true;
      text = ''
        # HYPR* and AQ_* variables
        export AQ_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1
      '';
    };

    ".config/uwsm/env" = {
      enable = true;
      executable = true;
      text = ''
        export QT_STYLE_OVERRIDE=Fusion
        export EGL_PLATFORM=wayland
        export NVD_BACKEND=direct
        export QT_QPA_PLATFORMTHEME=
        export VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json
        export LD_LIBRARY_PATH="/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
        export GBM_BACKENDS_PATH=/run/opengl-driver/lib/gbm
        export ELECTRON_OZONE_PLATFORM_HINT=auto
        export GBM_BACKEND=nvidia-drm
        export GDK_DPI_SCALE=${opts.desktop.scale}
        export GDK_SCALE=${opts.desktop.scale}
        export GTK_THEME=Adwaita:dark
        export LIBVA_DRIVER_NAME=nvidia
        export MOZ_ENABLE_WAYLAND=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=${opts.desktop.scale}
        export QT_QPA_PLATFORM=wayland
        export QT_SCALE_FACTOR=${opts.desktop.qt_scale_factor}
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export WINIT_X11_SCALE_FACTOR=${opts.desktop.scale}
        export XCURSOR_SIZE=28
        export XDG_CURRENT_DESKTOP=niri
        export XDG_DATA_DIRS="${config.home.profileDirectory}/share:/usr/local/share:/usr/share"
        export XDG_SESSION_DESKTOP=niri
        export XDG_SESSION_TYPE=wayland
      '';
    };
  };

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [
          "gtk"
          "gnome"
        ];
      };
      niri = {
        default = [
          "gtk"
          "gnome"
        ];
      };
    };
  };

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      debug = {
        render-drm-device = "/dev/dri/renderD128";
      };
      layout = {
        default-column-width = {
          proportion = 1.0;
        };
        shadow = {
          enable = false;
        };
        struts = {
          left = 16;
          right = 16;
        };
      };

      input = {
        keyboard = {
          xkb = {
            layout = "us,apl";
            options = "ctrl:nocaps,compose:ralt,grp:shifts_toggle";
            variant = ",dyalog";
          };
        };

        focus-follows-mouse = {
          enable = true;
        };

        tablet = {
          enable = true;
          left-handed = true;
          map-to-output = "eDP-1";
        };
      };

      switch-events = with config.lib.niri.actions; {
        lid-close.action = spawn "noctalia" "msg" "session" "lock";
      };

      spawn-at-startup = [
        { sh = "echo $NIRI_SOCKET > ~/.niri-socket"; }
        { sh = "dbus-update-activation-environment --systemd --all"; }
        { sh = "systemctl --user start xdg-desktop-portal-gnome.service"; }
        { sh = "systemctl --user start hyprpolkitagent"; }
        { sh = "clipse -listen"; }
        { sh = "wl-paste --type image --watch cliphist store"; }
        { sh = "wl-paste --type text --watch cliphist store"; }
        { sh = "wlsunset -l 40.7 -L -73.9"; }
        { sh = "xrdb ~/.Xresources"; }
      ];

      layer-rules = [
        {
          matches = [
            { namespace = "^noctalia-backdrop"; }
          ];
          place-within-backdrop = true;
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
          geometry-corner-radius = {
            bottom-left = 0.2;
            bottom-right = 0.2;
            top-left = 0.2;
            top-right = 0.2;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            { app-id = "dev.noctalia.Noctalia.Settings"; }
          ];
          open-floating = true;
          default-column-width = {
            fixed = 1080;
          };
          default-window-height = {
            fixed = 920;
          };
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
        "LG Electronics LG ULTRAFINE 602NTMXGY347" = {
          enable = true;
          position = {
            x = 0;
            y = 0;
          };
          scale = 2;
          mode = {
            width = 3840;
            height = 2160;
            refresh = 60.0;
          };
        };

        "LG Electronics LG ULTRAFINE 602NTRLGY358" = {
          enable = true;
          position = {
            x = 1920;
            y = 0;
          };
          scale = 2;
          mode = {
            width = 3840;
            height = 2160;
            refresh = 60.0;
          };
        };

        "Samsung Display Corp. 0x4177 Unknown" = {
          enable = true;
          position = {
            x = 0;
            y = 1080;
          };
          scale = 2;
          mode = {
            width = 3840;
            height = 2400;
            refresh = 60.0;
          };
        };
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

          "Ctrl+Space".action = spawn "noctalia" "msg" "notification-clear-active";
          "Mod+Ctrl+Space".action = spawn "noctalia" "msg" "session" "lock";

          "Ctrl+XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%-";
          "Ctrl+XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "Ctrl+XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%+";

          "Mod+Ctrl+H".action = focus-monitor-left;
          "Mod+Ctrl+L".action = focus-monitor-right;
          "Mod+Ctrl+K".action = focus-monitor-up;
          "Mod+Ctrl+J".action = focus-monitor-down;

          "Mod+Shift+H".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+L".action = move-column-right-or-to-monitor-right;
          "Mod+Shift+J".action = move-column-to-monitor-down;
          "Mod+Shift+K".action = move-column-to-monitor-up;

          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;

          "Mod+K".action = focus-workspace-up;
          "Mod+J".action = focus-workspace-down;

          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+0".action.focus-workspace = 10;

          "Mod+Shift+1".action.move-window-to-workspace = [
            { focus = true; }
            1
          ];
          "Mod+Shift+2".action.move-window-to-workspace = [
            { focus = true; }
            2
          ];
          "Mod+Shift+3".action.move-window-to-workspace = [
            { focus = true; }
            3
          ];
          "Mod+Shift+4".action.move-window-to-workspace = [
            { focus = true; }
            4
          ];
          "Mod+Shift+5".action.move-window-to-workspace = [
            { focus = true; }
            5
          ];
          "Mod+Shift+6".action.move-window-to-workspace = [
            { focus = true; }
            6
          ];
          "Mod+Shift+7".action.move-window-to-workspace = [
            { focus = true; }
            7
          ];
          "Mod+Shift+8".action.move-window-to-workspace = [
            { focus = true; }
            8
          ];
          "Mod+Shift+9".action.move-window-to-workspace = [
            { focus = true; }
            9
          ];
          "Mod+Shift+0".action.move-window-to-workspace = [
            { focus = true; }
            10
          ];

          "Mod+bracketleft".action = set-column-width "-10%";
          "Mod+bracketright".action = set-column-width "+10%";

          "Mod+Shift+E".action = spawn "uwsm" "stop";

          "Mod+Shift+Q".action = close-window;
          "Mod+F".action = fullscreen-window;

          # "Mod+A".action = spawn "pwvucontrol";
          "Mod+C".action = spawn "noctalia" "msg" "panel-toggle" "control-center";
          "Mod+D".action = spawn "${pkgs.vicinae}/bin/vicinae" "toggle";
          "Mod+N".action = spawn "noctalia" "msg" "notification-dnd-toggle";
          "Mod+S".action = spawn "noctalia" "msg" "settings-toggle";

          # "Mod+W".action = spawn "noctalia" "ipc" "call" "wallpaper" "toggle";
          "Mod+O".action = toggle-overview;
          "Mod+Shift+Return".action = spawn "${pkgs.kitty}/bin/kitty";
          "Mod+Return".action =
            spawn "${config.programs.kitty.package}/bin/kitty" "${pkgs.tmux}/bin/tmux" "new" "-A" "-s"
              "system";
          "Mod+KP_Enter".action =
            spawn "${config.programs.kitty.package}/bin/kitty" "${pkgs.tmux}/bin/tmux" "new" "-A" "-s"
              "system";
          "Mod+XF86AudioLowerVolume".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%-";
          "Mod+XF86AudioRaiseVolume".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%+";
          "Mod+Shift+S".action = sh ''
            ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
          '';
        };
    };
  };
}
