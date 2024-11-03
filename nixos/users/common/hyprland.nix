{ pkgs, config, ... }:
let
  hyprconf = {
    mod-key = "SUPER";
    terminal = "alacritty";
    filemanager = "nemo";
    menu = "${pkgs.rofi}/bin/rofi -show drun";
    window_switcher = "${pkgs.rofi}/bin/rofi -show window";
    envs = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __NV_PRIME_RENDER_OFFLOAD = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      XCURSOR_SIZE = "28";
      HYPRCURSOR_SIZE = "28";
      AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
      XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_SCALE_FACTOR = "1";
      WINIT_X11_SCALE_FACTOR = "1";
    };

    exec-once = [
      "waybar"
      "dunst"
      "hyprpaper"
    ];

    exec = [ ];

    monitors = [
      {
        name = "eDP-1";
        resolution = { x = 1920; y = 1200; };
        position = { x = 0; y = 1080; };
        rate = 60;
        scale = 1;
      }
      {
        name = "DP-3";
        resolution = { x = 1920; y = 1080; };
        position = { x = 0; y = 0; };
        rate = 60;
        scale = 1;
      }
      {
        name = "DP-2";
        resolution = { x = 3840; y = 2160; };
        position = { x = 1920; y = 0; };
        rate = 60;
        scale = 1.33333;
      }
    ];
  };

  genEnvs =
    envs: builtins.concatStringsSep "\n"
      (builtins.attrValues
        (builtins.mapAttrs (key: value: "env = ${key},${value}") envs));

  genExec =
    exectype: pgms: builtins.concatStringsSep "\n" (builtins.map (program: "${exectype} = ${program}") pgms);

  genExecOnce = genExec "exec-once";
  genExecAlways = genExec "exec";

  genMonitors =
    monitors:
    let
      genMonitor =
        monitor:
        let
          res = "${builtins.toString monitor.resolution.x}x${builtins.toString monitor.resolution.y}";
          position = "${builtins.toString monitor.position.x}x${builtins.toString monitor.position.y}";
          rate = builtins.toString monitor.rate;
          scale = builtins.toString monitor.scale;
          rhs = builtins.concatStringsSep ", " [ monitor.name "${res}@${rate}" position scale ];
        in
        "monitor = ${rhs}";
    in
    builtins.concatStringsSep "\n" (builtins.map genMonitor monitors);
in
{

  imports = [ ./waybar.nix ./hyprpaper.nix ];

  home.file = {
    ".config/hypr/hyprland.conf" = {
      enable = true;
      text = ''
        ${genMonitors   hyprconf.monitors}
        ${genExecOnce   hyprconf.exec-once}
        ${genExecAlways hyprconf.exec}
        ${genEnvs       hyprconf.envs}

        $terminal        = ${hyprconf.terminal}
        $fileManager     = ${hyprconf.filemanager}
        $menu            = ${hyprconf.menu}
        $window_switcher = ${hyprconf.window_switcher}
        $mainMod         = ${hyprconf.mod-key}

        cursor {
            no_hardware_cursors = true
        }

        xwayland {
          force_zero_scaling = true
        }

        bind = $mainMod, Return, exec, $terminal
        bind = $mainMod, KP_Enter, exec, $terminal
        bind = $mainMod SHIFT, Q, killactive
        bind = $mainMod SHIFT, E, exit
        bind = $mainMod, Tab, exec, $window_switcher
        bind = $mainMod SHIFT, Space, togglefloating
        bind = $mainMod, F, fullscreen
        bind = $mainMod, D, exec, $menu

        bind = CTRL, Space, exec, ${pkgs.dunst}/bin/dunstctl close-all
        bind = $mainMod, N, exec, ${pkgs.dunst}/bin/dunstctl set-paused toggle

        bind = $mainMod, H, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, J, movefocus, d

        bind = $mainMod SHIFT, H, swapwindow, l
        bind = $mainMod SHIFT, L, swapwindow, r
        bind = $mainMod SHIFT, K, swapwindow, u
        bind = $mainMod SHIFT, J, swapwindow, d

        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        bind = $mainMod SHIFT, S, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy

        bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bindel = ,XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+
        bindel = ,XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-
        bindl = , XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next
        bindl = , XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause
        bindl = , XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause
        bindl = , XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous

        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

        general {
          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
        }

        decoration {
            rounding = 10
            active_opacity = 1.0
            inactive_opacity = 1.0
            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
            blur {
              enabled = true
              size = 3
              passes = 1
              vibrancy = 0.1696
            }
        }

        dwindle {
            pseudotile = true
            preserve_split = true
        }

        animations {
            enabled = true
            bezier = myBezier, 0.05, 0.9, 0.1, 1.05
            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }

        master {
            new_status = master
        }

        misc {
            force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
        }

        gestures {
            workspace_swipe = false
        }

        device {
            name = epic-mouse-v1
            sensitivity = -0.5
        }

        input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options = ctrl:nocaps
          kb_rules =
          follow_mouse = 1
          sensitivity = 0
          touchpad {
              natural_scroll = false
          }
        }
      '';
    };
  };
}
