{
  pkgs,
  config,
  opts,
  ...
}:
let
  hypr-gamemode-toggle = import ./scripts/gamemode.nix { inherit pkgs; };
in
{
  envs = {
    AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    EGL_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GBM_BACKEND = "nvidia-drm";
    GDK_DPI_SCALE = "${opts.desktop.scale}";
    GDK_SCALE = "${opts.desktop.scale}";
    GTK_THEME = "Adwaita:dark";
    HYPRCURSOR_SIZE = "28";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_ENABLE_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "${opts.desktop.scale}";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "";
    QT_STYLE_OVERRIDE = "Fusion";
    QT_SCALE_FACTOR = "${opts.desktop.qt_scale_factor}";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WINIT_X11_SCALE_FACTOR = "${opts.desktop.scale}";
    XCURSOR_SIZE = "28";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

  inherit (opts) monitors;

  gestures = [
    {
      fingers = "3";
      direction = "horizontal";
      modifier = null;
      scale = null;
      action = "workspace";
      args = null;
    }
    {
      fingers = "2";
      direction = "pinchin";
      modifier = null;
      scale = null;
      action = "cursorZoom";
      args = "1.6, mult";
    }
    {
      fingers = "2";
      direction = "pinchout";
      modifier = null;
      scale = null;
      action = "cursorZoom";
      args = "0.625, mult";
    }
  ];

  decoration = {
    shadow = {
      enabled = "true";
      range = "4";
      sharp = "false";
      render_power = "3";
      color = "rgba(1a1a1aee)";
      color_inactive = "rgba(1a1a1aff)";
    };

    blur = {
      brightness = "1";
      contrast = "1";
      enabled = "false";
      new_optimizations = "true";
      noise = "0.0117";
      passes = "1";
      popups = "false";
      popups_ignorealpha = "0.0";
      input_methods_ignorealpha = "0.0";
      size = "4";
      special = "false";
      vibrancy = "0.1696";
      xray = "true";
    };
  };

  inputs = {
    kb_layout = "us,apl";
    kb_variant = ",dyalog";
    kb_model = "";
    kb_options = "ctrl:nocaps,compose:ralt,grp:shifts_toggle";
    kb_rules = "";
    follow_mouse = "1";
    sensitivity = "0";
    touchpad = {
      natural_scroll = "yes";
      disable_while_typing = "true";
      clickfinger_behavior = "true";
    };
    tablet = {
      transform = "2";
      output = "current";
    };
  };

  xwayland = {
    force_zero_scaling = "true";
  };

  dwindle = {
    pseudotile = "true";
    preserve_split = "true";
  };

  master = {
    mfact = "0.70";
  };

  scrolling = {
    fullscreen_on_one_column = "true";
    column_width = "0.75";
    focus_fit_method = "0"; # 0 = center; 1 = fit
    follow_focus = "true";
    direction = "right";
  };

  misc = {
    force_default_wallpaper = "0";
    disable_hyprland_logo = "true";
    focus_on_activate = "false";
    enable_swallow = "true";
    swallow_regex = "^(Alacritty|kitty)$";
    vrr = "0";
    vfr = "true";
  };

  general = {
    gaps_in = "5";
    gaps_out = "10";
    border_size = "2";
    resize_on_border = "false";
    allow_tearing = "false";
    layout = "scrolling";
    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
  };

  binds = {
    keyboard = [
      # Audio Outputs
      { mod = ""; keys = "XF86AudioLowerVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
      { mod = ""; keys = "XF86AudioRaiseVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; }
      { mod = ""; keys = "XF86AudioMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }

      # Audio Inputs
      { mod = ""; keys = "XF86AudioMicMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
      { mod = "CTRL"; keys = "XF86AudioLowerVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"; }
      { mod = "CTRL"; keys = "XF86AudioMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
      { mod = "CTRL"; keys = "XF86AudioRaiseVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"; }

      # Media Player Controls
      { mod = ""; keys = "XF86AudioNext"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl next"; }
      { mod = ""; keys = "XF86AudioPause"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl play-pause"; }
      { mod = ""; keys = "XF86AudioPlay"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl play-pause"; }
      { mod = ""; keys = "XF86AudioPrev"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl previous"; }

      # Brightness Controls
      { mod = ""; keys = "XF86MonBrightnessDown"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%-"; }
      { mod = ""; keys = "XF86MonBrightnessUp"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%+"; }
      { mod = "SUPER"; keys = "XF86AudioLowerVolume"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%-"; }
      { mod = "SUPER"; keys = "XF86AudioRaiseVolume"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%+"; }

      # Notifications Control
      { mod = "SUPER CTRL"; keys = "Escape"; dispatcher = "exec"; args = "noctalia ipc call notifications dismissAll"; } # Mod-C-Escape
      { mod = "SUPER"; keys = "Space"; dispatcher = "exec"; args = "noctalia ipc call notifications dismissAll"; } # Mod-Space

      # Workspace Navigation
      { mod = "SUPER"; keys = "1";      dispatcher = "workspace";              args = "r~1";  } # Mod-1
      { mod = "SUPER"; keys = "2";      dispatcher = "workspace";              args = "r~2";  } # Mod-2
      { mod = "SUPER"; keys = "3";      dispatcher = "workspace";              args = "r~3";  } # Mod-3
      { mod = "SUPER"; keys = "4";      dispatcher = "workspace";              args = "r~4";  } # Mod-4
      { mod = "SUPER"; keys = "5";      dispatcher = "workspace";              args = "r~5";  } # Mod-5
      { mod = "SUPER"; keys = "6";      dispatcher = "workspace";              args = "r~6";  } # Mod-6
      { mod = "SUPER"; keys = "7";      dispatcher = "workspace";              args = "r~7";  } # Mod-7
      { mod = "SUPER"; keys = "8";      dispatcher = "workspace";              args = "r~8";  } # Mod-8
      { mod = "SUPER"; keys = "9";      dispatcher = "workspace";              args = "r~9";  } # Mod-9
      { mod = "SUPER"; keys = "0";      dispatcher = "workspace";              args = "r~10"; } # Mod-0
      { mod = "SUPER"; keys = "Minus";  dispatcher = "workspace";              args = "r~11"; } # Mod-11
      { mod = "SUPER"; keys = "Equal";  dispatcher = "workspace";              args = "r~12"; } # Mod-12
      { mod = "SUPER"; keys = "Escape"; dispatcher = "togglespecialworkspace"; args = null;   } # Mod-Esc

      { mod = "SUPER"; keys = "mouse_down";   dispatcher = "workspace"; args = "r-1";     }
      { mod = "SUPER"; keys = "mouse_up";     dispatcher = "workspace"; args = "r+1";     }
      { mod = "SUPER"; keys = "mouse_left";   dispatcher = "layoutmsg"; args = "focus l"; }
      { mod = "SUPER"; keys = "mouse_right";  dispatcher = "layoutmsg"; args = "focus r"; }

      { mod = "SUPER SHIFT"; keys = "Space";  dispatcher = "togglefloating";  args = null;      } # S-Mod-Space
      { mod = "SUPER";       keys = "F";      dispatcher = "fullscreen";      args = null;      } # Mod-F
      { mod = "SUPER SHIFT"; keys = "Q";      dispatcher = "killactive";      args = null;      } # S-Mod-Q
      { mod = "SUPER SHIFT"; keys = "1";      dispatcher = "movetoworkspace"; args = "r~1";     } # S-Mod-1
      { mod = "SUPER SHIFT"; keys = "2";      dispatcher = "movetoworkspace"; args = "r~2";     } # S-Mod-2
      { mod = "SUPER SHIFT"; keys = "3";      dispatcher = "movetoworkspace"; args = "r~3";     } # S-Mod-3
      { mod = "SUPER SHIFT"; keys = "4";      dispatcher = "movetoworkspace"; args = "r~4";     } # S-Mod-4
      { mod = "SUPER SHIFT"; keys = "5";      dispatcher = "movetoworkspace"; args = "r~5";     } # S-Mod-5
      { mod = "SUPER SHIFT"; keys = "6";      dispatcher = "movetoworkspace"; args = "r~6";     } # S-Mod-6
      { mod = "SUPER SHIFT"; keys = "7";      dispatcher = "movetoworkspace"; args = "r~7";     } # S-Mod-7
      { mod = "SUPER SHIFT"; keys = "8";      dispatcher = "movetoworkspace"; args = "r~8";     } # S-Mod-8
      { mod = "SUPER SHIFT"; keys = "9";      dispatcher = "movetoworkspace"; args = "r~9";     } # S-Mod-9
      { mod = "SUPER SHIFT"; keys = "0";      dispatcher = "movetoworkspace"; args = "r~10";    } # S-Mod-0
      { mod = "SUPER SHIFT"; keys = "Equal";  dispatcher = "movetoworkspace"; args = "r~12";    } # S-Mod-Equal
      { mod = "SUPER SHIFT"; keys = "Minus";  dispatcher = "movetoworkspace"; args = "r~11";    } # S-Mod--
      { mod = "SUPER SHIFT"; keys = "Escape"; dispatcher = "movetoworkspace"; args = "special"; } # S-Mod-Esc

      { mod = "SUPER";       keys = "H"; dispatcher = "movefocus";    args = "l"; } # Mod-H
      { mod = "SUPER";       keys = "J"; dispatcher = "movefocus";    args = "d"; } # Mod-J
      { mod = "SUPER";       keys = "K"; dispatcher = "movefocus";    args = "u"; } # Mod-K
      { mod = "SUPER";       keys = "L"; dispatcher = "movefocus";    args = "r"; } # Mod-L

      { mod = "SUPER";       keys = "Tab"; dispatcher = "movefocus";  args = "r"; } # Mod-Tab
      { mod = "SUPER SHIFT"; keys = "Tab"; dispatcher = "movefocus";  args = "l"; } # S-Mod-Tab

      { mod = "SUPER SHIFT"; keys = "H"; dispatcher = "movewindow";   args = "l"; } # S-Mod-H
      { mod = "SUPER SHIFT"; keys = "J"; dispatcher = "movewindow";   args = "d"; } # S-Mod-J
      { mod = "SUPER SHIFT"; keys = "K"; dispatcher = "movewindow";   args = "u"; } # S-Mod-K
      { mod = "SUPER SHIFT"; keys = "L"; dispatcher = "movewindow";   args = "r"; } # S-Mod-L

      { mod = "SUPER CTRL";  keys = "H"; dispatcher = "focusmonitor"; args = "l"; } # C-Mod-H
      { mod = "SUPER CTRL";  keys = "L"; dispatcher = "focusmonitor"; args = "r"; } # C-Mod-L
      { mod = "SUPER CTRL";  keys = "J"; dispatcher = "focusmonitor"; args = "d"; } # C-Mod-J
      { mod = "SUPER CTRL";  keys = "K"; dispatcher = "focusmonitor"; args = "u"; } # C-Mod-K

      # Scrolling Layout Keybindings
      { mod = "SUPER"; keys = "x";            dispatcher = "layoutmsg"; args = "fit all";   }# Mod-x
      { mod = "SUPER"; keys = "bracketright"; dispatcher = "layoutmsg"; args = "fit tobeg"; }# Mod-]
      { mod = "SUPER"; keys = "bracketleft";  dispatcher = "layoutmsg"; args = "fit toend"; }# Mod-[

      # Desktop Mode Controls
      { mod = "SUPER CTRL";  keys = "Space"; dispatcher = "exec"; args = "noctalia ipc call lockScreen lock";    }# C-Mod-Space
      { mod = "SUPER SHIFT"; keys = "E";     dispatcher = "exit"; args = null;                                   }# S-Mod-E
      { mod = "SUPER";       keys = "P";     dispatcher = "exec"; args = "${hypr-gamemode-toggle}/bin/gamemode"; } # Mod-P

      # Launchers
      { mod = "SUPER";       keys = "D"; dispatcher = "exec"; args = "${pkgs.vicinae}/bin/vicinae toggle"; }# Mod-D
      { mod = "SUPER CTRL";  keys = "D"; dispatcher = "exec"; args = "${pkgs.rofi}/bin/rofi -show drun";   }# C-Mod-D
      { mod = "SUPER";       keys = "A"; dispatcher = "exec"; args = "uwsm app -t service -- re.fossplant.songrec.desktop"; } # Mod-A
      { mod = "SUPER";       keys = "B"; dispatcher = "exec"; args = "uwsm app -t service -- ${opts.desktop.browser.xdg-desktop}"; } # Mod-B
      { mod = "SUPER";       keys = "C"; dispatcher = "exec"; args = "noctalia ipc call controlCenter toggle"; } # Mod-C
      { mod = "SUPER";       keys = "W"; dispatcher = "exec"; args = "noctalia ipc call wallpaper toggle"; } # Mod-W
      { mod = "SUPER";       keys = "Q"; dispatcher = "exec"; args = "${pkgs.vicinae}/bin/vicinae vicinae://extensions/vicinae/clipboard/history"; } # Mod-Q
      { mod = "SUPER SHIFT"; keys = "Return"; dispatcher = "exec"; args = "${config.programs.kitty.package}/bin/kitty"; } # S-Mod-CR
      { mod = "SUPER";       keys = "Return"; dispatcher = "exec"; args = "${config.programs.kitty.package}/bin/kitty ${pkgs.tmux}/bin/tmux new -A -s system"; } # Mod-CR

      # Notifications Control
      { mod = "SUPER"; keys = "N"; dispatcher = "exec"; args = "noctalia ipc call notifications toggleDND"; } # Mod-N
      { mod = "SUPER"; keys = "backslash"; dispatcher = "exec"; args = "noctalia ipc call settings toggle"; } # Mod-\
      { mod = "SUPER"; keys = "S"; dispatcher = "toggleswallow"; args = null;                               } # Mod-S

      # Screen Capture
      { mod = "SUPER SHIFT"; keys = "S"; dispatcher = "exec"; args = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy"; } # S-Mod-S
      { mod = "SUPER CTRL";  keys = "S"; dispatcher = "exec"; args = "${pkgs.grim}/bin/grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') - | wl-copy"; } # C-Mod-S
      { mod = "SUPER ALT";   keys = "S"; dispatcher = "exec"; args = "${pkgs.grim}/bin/grim -g \"$(hyprctl activewindow -j | jq '(.at | \"\\(.[0]),\\(.[1])\"),(.size | \"\\(.[0])x\\(.[1])\")' | xargs)\" - | wl-copy"; } # M-Mod-S
    ];
    mouse = [
      { mod = "SUPER"; button = "mouse:272"; dispatcher = "movewindow"; args = null; }
    ];
  };

  rules = {
    workspace = [ ];
    window = [
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(Choose wallpaper)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Choose wallpaper)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(Choose wallpaper)(.*)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(Library)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Library)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(Library)(.*)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(Open Folder)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Open Folder)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(Open Folder)(.*)$" ];
      }
      {
        rule = "opacity 0.0 override";
        window_identifiers = [ "match:class ^(xwaylandvideobridge)$" ];
      }
      {
        rule = "no_anim on";
        window_identifiers = [ "match:class ^(xwaylandvideobridge)$" ];
      }
      {
        rule = "no_initial_focus on";
        window_identifiers = [ "match:class ^(xwaylandvideobridge)$" ];
      }
      {
        rule = "max_size 1 1";
        window_identifiers = [ "match:class ^(xwaylandvideobridge)$" ];
      }
      {
        rule = "no_blur on";
        window_identifiers = [ "match:class ^(xwaylandvideobridge)$" ];
      }
      {
        rule = "no_focus on";
        window_identifiers = [ "match:class ^(xwaylandvideobridge)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(File Upload)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(File Upload)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(File Upload)(.*)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(Select a File)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Select a File)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(Select a File)(.*)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(Save As)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Save As)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(Save As)(.*)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:title ^(Open File)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Open File)(.*)$" ];
      }
      {
        rule = "size 1000 600";
        window_identifiers = [ "match:title ^(Open File)(.*)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" ];
      }
      {
        rule = "suppress_event maximize";
        window_identifiers = [ "match:class .*" ];
      }
      {
        rule = "float on";
        window_identifiers = [
          "match:class ^(firefox)$"
          "match:title ^(Picture-in-Picture)$"
        ];
      }
      {
        rule = "float on";
        window_identifiers = [
          "match:class ^(firefox)$"
          "match:title ^(Library)$"
        ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:class ^(Signal)$" ];
      }
      {
        rule = "center on";
        window_identifiers = [ "match:class ^(Rofi)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:class ^(Rofi)$" ];
      }
      {
        rule = "rounding 10";
        window_identifiers = [ "match:class ^(Rofi)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(About Mozilla Firefox)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:class ^(com.saivert.pwvucontrol)$" ];
      }
      {
        rule = "size 1400 650";
        window_identifiers = [ "match:class ^(com.saivert.pwvucontrol)$" ];
      }
      {
        rule = "keep_aspect_ratio on";
        window_identifiers = [ "match:title ^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "move 73% 72%";
        window_identifiers = [ "match:title ^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "size 25%";
        window_identifiers = [ "match:title ^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "float on";
        window_identifiers = [ "match:title ^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "pin on";
        window_identifiers = [ "match:title ^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "immediate on";
        window_identifiers = [ "match:class (steam_app)" ];
      }
      {
        rule = "no_shadow on";
        window_identifiers = [ "match:float 0" ];
      }
      {
        rule = "tile on";
        window_identifiers = [ "match:class ^(Nsxiv)$" ];
      }
      {
        rule = "no_focus on";
        window_identifiers = [
          "match:class ^$"
          "match:title ^$"
          "match:xwayland 1"
          "match:float 1"
          "match:fullscreen 0"
          "match:pin 0"
        ];
      }
    ];

    layer = [
      { rule = "animation slide left"; addr = "sideleft.*"; }
      { rule = "animation slide right"; addr = "sideright.*"; }
      { rule = "blur on"; addr = "bar"; }
      { rule = "blur on"; addr = "cheatsheet"; }
      { rule = "blur on"; addr = "corner.*"; }
      { rule = "blur on"; addr = "dock"; }
      { rule = "blur on"; addr = "gtk-layer-shell"; }
      { rule = "blur on"; addr = "indicator*"; }
      { rule = "blur on"; addr = "indicator.*"; }
      { rule = "blur on"; addr = "launcher"; }
      { rule = "blur on"; addr = "notifications"; }
      { rule = "blur on"; addr = "notifications"; }
      { rule = "blur on"; addr = "osk"; }
      { rule = "blur on"; addr = "overview"; }
      { rule = "blur on"; addr = "rofi"; }
      { rule = "blur on"; addr = "session"; }
      { rule = "blur on"; addr = "shell:*"; }
      { rule = "blur on"; addr = "sideleft"; }
      { rule = "blur on"; addr = "sideright"; }
      { rule = "blur on"; addr = "vicinae"; }
      { rule = "ignore_alpha 0"; addr = "rofi"; }
      { rule = "ignore_alpha 0"; addr = "vicinae"; }
      { rule = "ignore_alpha 0.5"; addr = "launcher"; }
      { rule = "ignore_alpha 0.6"; addr = "bar"; }
      { rule = "ignore_alpha 0.6"; addr = "cheatsheet"; }
      { rule = "ignore_alpha 0.6"; addr = "corner.*"; }
      { rule = "ignore_alpha 0.6"; addr = "dock"; }
      { rule = "ignore_alpha 0.6"; addr = "indicator*"; }
      { rule = "ignore_alpha 0.6"; addr = "indicator.*"; }
      { rule = "ignore_alpha 0.6"; addr = "osk"; }
      { rule = "ignore_alpha 0.6"; addr = "overview"; }
      { rule = "ignore_alpha 0.6"; addr = "shell:*"; }
      { rule = "ignore_alpha 0.6"; addr = "sideleft"; }
      { rule = "ignore_alpha 0.6"; addr = "sideright"; }
      { rule = "ignore_alpha 0.69"; addr = "notifications"; }
      { rule = "ignore_alpha 0.1"; addr = "gtk-layer-shell"; }
      { rule = "ignore_alpha 0.1"; addr = "notifications"; }
      { rule = "ignore_alpha 0.1"; addr = "notifications"; }
      { rule = "ignore_alpha 0.1"; addr = "rofi"; }
      { rule = "no_anim on"; addr = "anyrun"; }
      { rule = "no_anim on"; addr = "hyprpicker"; }
      { rule = "no_anim on"; addr = "indicator.*"; }
      { rule = "no_anim on"; addr = "noanim"; }
      { rule = "no_anim on"; addr = "osk"; }
      { rule = "no_anim on"; addr = "overview"; }
      { rule = "no_anim on"; addr = "rofi"; }
      { rule = "no_anim on"; addr = "selection"; }
      { rule = "no_anim on"; addr = "vicinae"; }
      { rule = "no_anim on"; addr = "walker"; }
      { rule = "xray on"; addr = ".*"; }
    ];
  };

  exec-once = [
    "dbus-update-activation-environment --systemd --all"
    "hyprpm reload -n"
    "clipse -listen"
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
    "wlsunset -l 40.7 -L -73.9"
    "xrdb ~/.Xresources"

    # TODO: systemctl --user enable --now hyprpolkitagent will work with uwsm,
    # but not reproducible in current setup
    "systemctl --user start hyprpolkitagent"
  ];

  exec = [ ];
}
