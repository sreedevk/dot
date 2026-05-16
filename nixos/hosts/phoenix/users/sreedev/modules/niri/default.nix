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
        export __EGL_EXTERNAL_PLATFORM_CONFIG_DIRS=/usr/share/egl/egl_external_platform.d
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
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __GL_GSYNC_ALLOWED=1
        export __GL_VRR_ALLOWED=1
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __VK_LAYER_NV_optimus=NVIDIA_only
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
        struts = {
          left = 16;
          right = 16;
        };
      };

      input.keyboard = {
        xkb = {
          layout = "us";
          options = "ctrl:nocaps";
        };
      };

      input.tablet = {
        enable = true;
        left-handed = true;
        map-to-output = "DP-2";
      };

      spawn-at-startup = [
        { sh = "echo $NIRI_SOCKET > ~/.niri-socket";                 }
        { sh = "dbus-update-activation-environment --systemd --all"; }
        { sh = "systemctl --user start hyprpolkitagent"; }
        { sh = "clipse -listen";                          }
        { sh = "wl-paste --type image --watch cliphist store";       }
        { sh = "wl-paste --type text --watch cliphist store";        }
        { sh = "wlsunset -l 40.7 -L -73.9";                          }
        { sh = "xrdb ~/.Xresources";                                 }
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
          name = "Samsung Display Corp. 0x4177";
          position = {
            x = 0;
            y = 0;
          };
          scale = 2;
          variable-refresh-rate = "on-demand";
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

          "Ctrl+Space".action = spawn "noctalia" "ipc" "call" "notifications" "dismissAll";
          "Ctrl+XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%-";
          "Ctrl+XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "Ctrl+XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "5%+";

          "Mod+H".action = focus-column-or-monitor-left;
          "Mod+L".action = focus-column-or-monitor-right;

          "Mod+Shift+H".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+L".action = move-column-right-or-to-monitor-right;

          "Mod+K".action = focus-workspace-up;
          "Mod+J".action = focus-workspace-down;

          "Mod+1".action = focus-column 1;
          "Mod+2".action = focus-column 2;
          "Mod+3".action = focus-column 3;
          "Mod+4".action = focus-column 4;
          "Mod+5".action = focus-column 5;
          "Mod+6".action = focus-column 6;
          "Mod+7".action = focus-column 7;
          "Mod+8".action = focus-column 8;
          "Mod+9".action = focus-column 9;
          "Mod+0".action = focus-column 10;

          "Mod+Ctrl+H".action = set-column-width "-10%";
          "Mod+Ctrl+L".action = set-column-width "+10%";

          "Mod+Shift+E".action = spawn "uwsm" "stop";

          "Mod+Shift+J".action = move-window-to-workspace-down { focus = true; };
          "Mod+Shift+K".action = move-window-to-workspace-up { focus = true; };

          # TODO: USE THIS TO SWITCH MONITORS
          # "Mod+Tab".action = focus-column-right-or-first;
          # "Mod+Shift+Tab".action = focus-column-right-or-first;

          "Mod+Shift+Q".action = close-window;
          "Mod+F".action = toggle-windowed-fullscreen;

          "Mod+A".action = spawn "pwvucontrol";
          "Mod+C".action = spawn "noctalia" "ipc" "call" "controlCenter" "toggle";
          "Mod+D".action = spawn "${pkgs.vicinae}/bin/vicinae" "toggle";
          "Mod+N".action = spawn "noctalia" "ipc" "call" "notifications" "toggleDND";
          "Mod+S".action = spawn "noctalia" "ipc" "call" "settings" "toggle";
          "Mod+W".action = spawn "noctalia" "ipc" "call" "wallpaper" "toggle";
          "Mod+O".action = toggle-overview;
          "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
          "Mod+Shift+Return".action =
            spawn "${config.programs.kitty.package}/bin/kitty ${pkgs.tmux}/bin/tmux new -A -s system";
          "Mod+KP_Enter".action = spawn "${config.programs.kitty.package}/bin/kitty";
          "Mod+XF86AudioLowerVolume".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%-";
          "Mod+XF86AudioRaiseVolume".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%+";
          "Mod+Shift+S".action = sh ''
            ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
          '';
        };
    };
  };
}
