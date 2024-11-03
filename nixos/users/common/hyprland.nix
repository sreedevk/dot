{ pkgs, config, opts, ... }:
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
          rhs = builtins.concatStringsSep ", " [ "desc:${monitor.desc}" "${res}@${rate}" position scale ];
        in
        "monitor = ${rhs}";
    in
    builtins.concatStringsSep "\n" (builtins.map genMonitor monitors);
in
{

  imports = [ ./waybar.nix ./hyprpaper.nix ];

  home.file = {
    ".config/hypr/monitors.conf" = {
      enable = true;
      text = genMonitors opts.hyprland.monitors;
    };

    ".config/hypr/hyprland.conf" = {
      enable = true;
      text = ''
        source = ~/.config/hypr/monitors.conf
        ${genExecOnce   hyprconf.exec-once}
        ${genExecAlways hyprconf.exec}
        ${genEnvs       hyprconf.envs}

        $terminal        = ${hyprconf.terminal}
        $fileManager     = ${hyprconf.filemanager}
        $menu            = ${hyprconf.menu}
        $window_switcher = ${hyprconf.window_switcher}
        $mod             = ${hyprconf.mod-key}

        cursor {
            no_hardware_cursors = true
        }

        xwayland {
          force_zero_scaling = true
        }

        bind = $mod       , Return   , exec            , $terminal
        bind = $mod       , KP_Enter , exec            , $terminal
        bind = $mod SHIFT , Q        , killactive
        bind = $mod SHIFT , E        , exit
        bind = $mod       , Tab      , exec            , $window_switcher
        bind = $mod SHIFT , Space    , togglefloating
        bind = $mod       , F        , fullscreen
        bind = $mod       , D        , exec            , $menu
        bind = $mod SHIFT , C        , exec            , hyprctl reload

        bind = CTRL       , Space    , exec            , ${pkgs.dunst}/bin/dunstctl close-all
        bind = $mod       , N        , exec            , ${pkgs.dunst}/bin/dunstctl set-paused toggle

        bind = $mod       , H        , movefocus       , l
        bind = $mod       , L        , movefocus       , r
        bind = $mod       , K        , movefocus       , u
        bind = $mod       , J        , movefocus       , d

        bind = $mod SHIFT , H        , swapwindow      , l
        bind = $mod SHIFT , L        , swapwindow      , r
        bind = $mod SHIFT , K        , swapwindow      , u
        bind = $mod SHIFT , J        , swapwindow      , d

        bind = $mod       , 1        , workspace       , 1
        bind = $mod       , 2        , workspace       , 2
        bind = $mod       , 3        , workspace       , 3
        bind = $mod       , 4        , workspace       , 4
        bind = $mod       , 5        , workspace       , 5
        bind = $mod       , 6        , workspace       , 6
        bind = $mod       , 7        , workspace       , 7
        bind = $mod       , 8        , workspace       , 8
        bind = $mod       , 9        , workspace       , 9
        bind = $mod       , 0        , workspace       , 10

        bind = $mod SHIFT , 1        , movetoworkspace , 1
        bind = $mod SHIFT , 2        , movetoworkspace , 2
        bind = $mod SHIFT , 3        , movetoworkspace , 3
        bind = $mod SHIFT , 4        , movetoworkspace , 4
        bind = $mod SHIFT , 5        , movetoworkspace , 5
        bind = $mod SHIFT , 6        , movetoworkspace , 6
        bind = $mod SHIFT , 7        , movetoworkspace , 7
        bind = $mod SHIFT , 8        , movetoworkspace , 8
        bind = $mod SHIFT , 9        , movetoworkspace , 9
        bind = $mod SHIFT , 0        , movetoworkspace , 10

        bind = $mod SHIFT , S        , exec            , ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy

        bindel = , XF86AudioRaiseVolume  , exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindel = , XF86AudioLowerVolume  , exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindel = , XF86AudioMute         , exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindel = , XF86AudioMicMute      , exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bindel = , XF86MonBrightnessUp   , exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+
        bindel = , XF86MonBrightnessDown , exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-

        bindl =  , XF86AudioNext         , exec, ${pkgs.playerctl}/bin/playerctl next
        bindl =  , XF86AudioPause        , exec, ${pkgs.playerctl}/bin/playerctl play-pause
        bindl =  , XF86AudioPlay         , exec, ${pkgs.playerctl}/bin/playerctl play-pause
        bindl =  , XF86AudioPrev         , exec, ${pkgs.playerctl}/bin/playerctl previous

        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

        general {
          gaps_in             = 5
          gaps_out            = 20
          border_size         = 2
          col.active_border   = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border    = false
          allow_tearing       = false
          layout              = dwindle
        }

        decoration {
            rounding            = 10
            active_opacity      = 1.0
            inactive_opacity    = 1.0
            drop_shadow         = true
            shadow_range        = 4
            shadow_render_power = 3
            col.shadow          = rgba(1a1a1aee)

            blur {
              enabled   = true
              size      = 3
              passes    = 1
              vibrancy  = 0.1696
            }
        }

        dwindle {
            pseudotile     = true
            preserve_split = true
        }

        animations {
            enabled   = true
            bezier    = myBezier, 0.05, 0.9, 0.1, 1.05
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
            force_default_wallpaper = 0
            disable_hyprland_logo   = true
        }

        gestures {
            workspace_swipe = false
        }

        device {
            name        = epic-mouse-v1
            sensitivity = -0.5
        }

        input {
          kb_layout           = us
          kb_variant          =
          kb_model            =
          kb_options          = ctrl:nocaps
          kb_rules            =
          follow_mouse        = 1
          sensitivity         = 0
          touchpad {
              natural_scroll  = false
          }
        }
      '';
    };
  };
}
