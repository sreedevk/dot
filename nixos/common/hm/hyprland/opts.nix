{ pkgs
, config
, opts
, ...
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

  misc = {
    force_default_wallpaper = "0";
    disable_hyprland_logo = "true";
    focus_on_activate = "false";
    vrr = "0";
    vfr = "true";
  };

  animations = {
    enabled = "true";
    bezier = [
      "linear, 0, 0, 1, 1"
      "md3_standard, 0.2, 0, 0, 1"
      "md3_decel, 0.05, 0.7, 0.1, 1"
      "md3_accel, 0.3, 0, 0.8, 0.15"
      "overshot, 0.05, 0.9, 0.1, 1.1"
      "crazyshot, 0.1, 1.5, 0.76, 0.92"
      "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
      "menu_decel, 0.1, 1, 0, 1"
      "menu_accel, 0.38, 0.04, 1, 0.07"
      "easeInOutCirc, 0.85, 0, 0.15, 1"
      "easeOutCirc, 0, 0.55, 0.45, 1"
      "easeOutExpo, 0.16, 1, 0.3, 1"
      "softAcDecel, 0.26, 0.26, 0.15, 1"
      "md2, 0.4, 0, 0.2, 1"
    ];
    animation = [
      "windows, 1, 3, md3_decel, popin 60%"
      "windowsIn, 1, 3, md3_decel, popin 60%"
      "windowsOut, 1, 3, md3_accel, popin 60%"
      "border, 1, 10, default"
      "fade, 1, 3, md3_decel"
      "layersIn, 1, 3, menu_decel, slide"
      "layersOut, 1, 1.6, menu_accel"
      "fadeLayersIn, 1, 2, menu_decel"
      "fadeLayersOut, 1, 4.5, menu_accel"
      "workspaces, 1, 7, menu_decel, slide"
      "specialWorkspace, 1, 3, md3_decel, slidevert"
    ];
  };

  general = {
    gaps_in = "5";
    gaps_out = "10";
    border_size = "2";
    resize_on_border = "false";
    allow_tearing = "false";
    layout = "master";
    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
  };

  binds = {
    keyboard = [
      { mod = ""; keys = "XF86AudioLowerVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
      { mod = ""; keys = "XF86AudioMicMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
      { mod = ""; keys = "XF86AudioMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
      { mod = ""; keys = "XF86AudioNext"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl next"; }
      { mod = ""; keys = "XF86AudioPause"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl play-pause"; }
      { mod = ""; keys = "XF86AudioPlay"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl play-pause"; }
      { mod = ""; keys = "XF86AudioPrev"; dispatcher = "exec"; args = "${pkgs.playerctl}/bin/playerctl previous"; }
      { mod = ""; keys = "XF86AudioRaiseVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; }
      { mod = ""; keys = "XF86MonBrightnessDown"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%-"; }
      { mod = ""; keys = "XF86MonBrightnessUp"; dispatcher = "exec"; args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%+"; }
      { mod = "CTRL"; keys = "Space"; dispatcher = "exec"; args = "noctalia ipc call notifications dismissAll"; }
      { mod = "CTRL"; keys = "XF86AudioLowerVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"; }
      { mod = "CTRL"; keys = "XF86AudioMute"; dispatcher = "exec"; args = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
      { mod = "CTRL"; keys = "XF86AudioRaiseVolume"; dispatcher = "exec"; args = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"; }
      { mod = "SUPER CTRL"; keys = "H"; dispatcher = "changegroupactive"; args = "b"; }
      { mod = "SUPER CTRL"; keys = "L"; dispatcher = "changegroupactive"; args = "f"; }
      { mod = "SUPER CTRL"; keys = "D"; dispatcher = "exec"; args = "${pkgs.rofi}/bin/rofi -show drun"; }
      { mod = "SUPER CTRL"; keys = "Space"; dispatcher = "exec"; args = "noctalia ipc call lockScreen lock"; }
      { mod = "SUPER";      keys = "Space"; dispatcher = "exec"; args = "noctalia ipc call notifications dismissAll"; }

      # workspace switching
      { mod = "SUPER SHIFT"; keys = "0"; dispatcher = "movetoworkspace"; args = "10"; }
      { mod = "SUPER SHIFT"; keys = "1"; dispatcher = "movetoworkspace"; args = "1"; }
      { mod = "SUPER SHIFT"; keys = "2"; dispatcher = "movetoworkspace"; args = "2"; }
      { mod = "SUPER SHIFT"; keys = "3"; dispatcher = "movetoworkspace"; args = "3"; }
      { mod = "SUPER SHIFT"; keys = "4"; dispatcher = "movetoworkspace"; args = "4"; }
      { mod = "SUPER SHIFT"; keys = "5"; dispatcher = "movetoworkspace"; args = "5"; }
      { mod = "SUPER SHIFT"; keys = "6"; dispatcher = "movetoworkspace"; args = "6"; }
      { mod = "SUPER SHIFT"; keys = "7"; dispatcher = "movetoworkspace"; args = "7"; }
      { mod = "SUPER SHIFT"; keys = "8"; dispatcher = "movetoworkspace"; args = "8"; }
      { mod = "SUPER SHIFT"; keys = "9"; dispatcher = "movetoworkspace"; args = "9"; }
      { mod = "SUPER SHIFT"; keys = "Equal"; dispatcher = "movetoworkspace"; args = "12"; }
      { mod = "SUPER SHIFT"; keys = "Escape"; dispatcher = "movetoworkspace"; args = "special"; }
      { mod = "SUPER SHIFT"; keys = "Minus"; dispatcher = "movetoworkspace"; args = "11"; }

      { mod = "SUPER SHIFT"; keys = "E"; dispatcher = "exit"; args = ""; }
      { mod = "SUPER SHIFT"; keys = "H"; dispatcher = "swapwindow"; args = "l"; }
      { mod = "SUPER SHIFT"; keys = "J"; dispatcher = "swapwindow"; args = "d"; }
      { mod = "SUPER SHIFT"; keys = "K"; dispatcher = "swapwindow"; args = "u"; }
      { mod = "SUPER SHIFT"; keys = "L"; dispatcher = "swapwindow"; args = "r"; }
      { mod = "SUPER SHIFT"; keys = "Q"; dispatcher = "killactive"; args = ""; }
      { mod = "SUPER SHIFT"; keys = "Space"; dispatcher = "togglefloating"; args = ""; }
      { mod = "SUPER SHIFT"; keys = "Tab"; dispatcher = "layoutmsg"; args = "rollprev"; }

      { mod = "SUPER"; keys = "0"; dispatcher = "workspace"; args = "10"; }
      { mod = "SUPER"; keys = "1"; dispatcher = "workspace"; args = "1"; }
      { mod = "SUPER"; keys = "2"; dispatcher = "workspace"; args = "2"; }
      { mod = "SUPER"; keys = "3"; dispatcher = "workspace"; args = "3"; }
      { mod = "SUPER"; keys = "4"; dispatcher = "workspace"; args = "4"; }
      { mod = "SUPER"; keys = "5"; dispatcher = "workspace"; args = "5"; }
      { mod = "SUPER"; keys = "6"; dispatcher = "workspace"; args = "6"; }
      { mod = "SUPER"; keys = "7"; dispatcher = "workspace"; args = "7"; }
      { mod = "SUPER"; keys = "8"; dispatcher = "workspace"; args = "8"; }
      { mod = "SUPER"; keys = "9"; dispatcher = "workspace"; args = "9"; }
      { mod = "SUPER"; keys = "Minus"; dispatcher = "workspace"; args = "11"; }
      { mod = "SUPER"; keys = "Equal"; dispatcher = "workspace"; args = "12"; }
      { mod = "SUPER"; keys = "Escape"; dispatcher = "togglespecialworkspace"; args = ""; }
      { mod = "SUPER"; keys = "A"; dispatcher = "exec"; args = "uwsm app -t service -- com.github.marinm.songrec.desktop"; }
      { mod = "SUPER"; keys = "B"; dispatcher = "exec"; args = "uwsm app -t service -- ${opts.desktop.browser.xdg-desktop}"; }
      { mod = "SUPER"; keys = "C"; dispatcher = "exec"; args = "noctalia ipc call controlCenter toggle"; }
      { mod = "SUPER"; keys = "D"; dispatcher = "exec"; args = "${pkgs.vicinae}/bin/vicinae toggle"; }
      { mod = "SUPER"; keys = "F"; dispatcher = "fullscreen"; args = ""; }
      { mod = "SUPER"; keys = "G"; dispatcher = "togglegroup"; args = ""; }
      { mod = "SUPER"; keys = "H"; dispatcher = "movefocus"; args = "l"; }
      { mod = "SUPER"; keys = "J"; dispatcher = "movefocus"; args = "d"; }
      { mod = "SUPER"; keys = "K"; dispatcher = "movefocus"; args = "u"; }
      { mod = "SUPER"; keys = "L"; dispatcher = "movefocus"; args = "r"; }
      { mod = "SUPER"; keys = "N"; dispatcher = "exec"; args = "noctalia ipc call notifications toggleDND"; }
      { mod = "SUPER"; keys = "P"; dispatcher = "exec"; args = "${hypr-gamemode-toggle}/bin/gamemode"; }
      { mod = "SUPER"; keys = "Q"; dispatcher = "exec"; args = "${pkgs.vicinae}/bin/vicinae vicinae://extensions/vicinae/clipboard/history"; }
      { mod = "SUPER"; keys = "S"; dispatcher = "exec"; args = "noctalia ipc call settings toggle"; }
      { mod = "SUPER"; keys = "W"; dispatcher = "exec"; args = "noctalia ipc call wallpaper toggle"; }
      { mod = "SUPER"; keys = "Return"; dispatcher = "exec"; args = "${config.programs.kitty.package}/bin/kitty"; }
      { mod = "SUPER"; keys = "Tab"; dispatcher = "layoutmsg"; args = "rollnext"; }
      { mod = "SUPER"; keys = "m"; dispatcher = "layoutmsg"; args = "swapwithmaster master"; }
      { mod = "SUPER"; keys = "x"; dispatcher = "exec"; args = "hyprctl kill"; }
      { mod = "SUPER"; keys = "E"; dispatcher = "exec"; args = "uwsm app -t service -- org.mozilla.Thunderbird.desktop"; }
      {
        mod = "SUPER";
        keys = "XF86AudioLowerVolume";
        dispatcher = "exec";
        args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%-";
      }
      {
        mod = "SUPER";
        keys = "XF86AudioRaiseVolume";
        dispatcher = "exec";
        args = "${pkgs.brightnessctl}/bin/brightnessctl s 10%+";
      }
      {
        mod = "SUPER SHIFT";
        keys = "Return";
        dispatcher = "exec";
        args = "${config.programs.kitty.package}/bin/kitty ${pkgs.tmux}/bin/tmux new -A -s system";
      }
      {
        mod = "SUPER SHIFT";
        keys = "S";
        dispatcher = "exec";
        args = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy";
      }
      {
        mod = "SUPER CTRL";
        keys = "S";
        dispatcher = "exec";
        args = "${pkgs.grim}/bin/grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') - | wl-copy";
      }
      {
        mod = "SUPER ALT";
        keys = "S";
        dispatcher = "exec";
        args = "${pkgs.grim}/bin/grim -g \"$(hyprctl activewindow -j | jq '(.at | \"\\(.[0]),\\(.[1])\"),(.size | \"\\(.[0])x\\(.[1])\")' | xargs)\" - | wl-copy";
      }
    ];
    mouse = [
      {
        mod = "SUPER";
        button = "mouse:272";
        dispatcher = "movewindow";
      }
    ];
  };

  rules = {
    workspace = [
      {
        workspace_label = "1";
        rules = [
          "monitor:desc:LG Electronics LG Ultra HD 0x00073F78"
          "default:true"
        ];
      }
      {
        workspace_label = "2";
        rules = [
          "monitor:desc:LG Electronics LG Ultra HD 0x00073F78"
          "default:false"
        ];
      }
      {
        workspace_label = "3";
        rules = [
          "monitor:desc:LG Electronics LG Ultra HD 0x00073F78"
          "default:false"
        ];
      }
      {
        workspace_label = "4";
        rules = [
          "monitor:desc:AU Optronics 0xF99A"
          "default:true"
        ];
      }
      {
        workspace_label = "5";
        rules = [
          "monitor:desc:XEC ES-24X3A 0x00000022"
          "default:true"
        ];
      }
      {
        workspace_label = "6";
        rules = [
          "monitor:desc:XEC ES-24X3A 0x00000022"
          "default:false"
        ];
      }
      {
        workspace_label = "7";
        rules = [
          "monitor:desc:XEC ES-24X3A 0x00000022"
          "default:false"
        ];
      }
    ];

    window = [
      {
        rule = "center";
        window_identifiers = "title:^(Choose wallpaper)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(Choose wallpaper)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(Choose wallpaper)(.*)$";
      }

      {
        rule = "center";
        window_identifiers = "title:^(Library)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(Library)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(Library)(.*)$";
      }

      {
        rule = "center";
        window_identifiers = "title:^(Open Folder)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(Open Folder)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(Open Folder)(.*)$";
      }

      {
        rule = "opacity 0.0 override";
        window_identifiers = "class:^(xwaylandvideobridge)$";
      }
      {
        rule = "noanim";
        window_identifiers = "class:^(xwaylandvideobridge)$";
      }
      {
        rule = "noinitialfocus";
        window_identifiers = "class:^(xwaylandvideobridge)$";
      }
      {
        rule = "maxsize 1 1";
        window_identifiers = "class:^(xwaylandvideobridge)$";
      }
      {
        rule = "noblur";
        window_identifiers = "class:^(xwaylandvideobridge)$";
      }
      {
        rule = "nofocus";
        window_identifiers = "class:^(xwaylandvideobridge)$";
      }

      {
        rule = "center";
        window_identifiers = "title:^(File Upload)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(File Upload)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(File Upload)(.*)$";
      }

      {
        rule = "center";
        window_identifiers = "title:^(Select a File)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(Select a File)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(Select a File)(.*)$";
      }

      {
        rule = "center";
        window_identifiers = "title:^(Save As)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(Save As)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(Save As)(.*)$";
      }

      {
        rule = "center";
        window_identifiers = "title:^(Open File)(.*)$";
      }
      {
        rule = "float";
        window_identifiers = "title:^(Open File)(.*)$";
      }
      {
        rule = "size 1000 600";
        window_identifiers = "title:^(Open File)(.*)$";
      }
    ];

    windowv2 = [
      {
        rule = "float";
        window_identifiers = [ "title:^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" ];
      }
      {
        rule = "nofocus";
        window_identifiers = [
          "class:^$"
          "title:^$"
          "xwayland:1"
          "floating:1"
          "fullscreen:0"
          "pinned:0"
        ];
      }
      {
        rule = "suppressevent maximize";
        window_identifiers = [ "class:.*" ];
      }
      {
        rule = "float";
        window_identifiers = [
          "class:^(firefox)$"
          "title:^(Picture-in-Picture)$"
        ];
      }
      {
        rule = "float";
        window_identifiers = [
          "class:^(firefox)$"
          "title:^(Library)$"
        ];
      }
      {
        rule = "float";
        window_identifiers = [ "class:^(Signal)$" ];
      }

      {
        rule = "center";
        window_identifiers = [ "class:^(Rofi)$" ];
      }
      {
        rule = "float";
        window_identifiers = [ "class:^(Rofi)$" ];
      }
      {
        rule = "rounding 10";
        window_identifiers = [ "class:^(Rofi)$" ];
      }

      {
        rule = "workspace 4 silent";
        window_identifiers = [ "class:^(Slack)$" ];
      }
      {
        rule = "workspace 2 silent";
        window_identifiers = [ "class:^(firefox)$" ];
      }
      {
        rule = "workspace 5 silent";
        window_identifiers = [ "class:^(Brave-browser)$" ];
      }
      {
        rule = "workspace 3 silent";
        window_identifiers = [ "class:^(thunderbird)$" ];
      }

      {
        rule = "float";
        window_identifiers = [ "title:^(About Mozilla Firefox)$" ];
      }
      {
        rule = "float";
        window_identifiers = [ "class:^(com.saivert.pwvucontrol)$" ];
      }
      {
        rule = "size 1400 650";
        window_identifiers = [ "class:^(com.saivert.pwvucontrol)$" ];
      }
      {
        rule = "keepaspectratio";
        window_identifiers = [ "title:^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "move 73% 72%";
        window_identifiers = [ "title:^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "size 25%";
        window_identifiers = [ "title:^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "float";
        window_identifiers = [ "title:^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "pin";
        window_identifiers = [ "title:^(Picture(-| )in(-| )[Pp]icture)$" ];
      }
      {
        rule = "immediate";
        window_identifiers = [ "class:(steam_app)" ];
      }
      {
        rule = "noshadow";
        window_identifiers = [ "floating:0" ];
      }

      {
        rule = "tile";
        window_identifiers = [ "class:^(Nsxiv)$" ];
      }
    ];

    layer = [
      {
        rule = "animation slide left";
        addr = "sideleft.*";
      }
      {
        rule = "animation slide right";
        addr = "sideright.*";
      }
      {
        rule = "blur";
        addr = "bar";
      }
      {
        rule = "blur";
        addr = "cheatsheet";
      }
      {
        rule = "blur";
        addr = "corner.*";
      }
      {
        rule = "blur";
        addr = "dock";
      }
      {
        rule = "blur";
        addr = "gtk-layer-shell";
      }
      {
        rule = "blur";
        addr = "indicator*";
      }
      {
        rule = "blur";
        addr = "indicator.*";
      }
      {
        rule = "blur";
        addr = "launcher";
      }
      {
        rule = "blur";
        addr = "notifications";
      }
      {
        rule = "blur";
        addr = "notifications";
      }
      {
        rule = "blur";
        addr = "osk";
      }
      {
        rule = "blur";
        addr = "overview";
      }
      {
        rule = "blur";
        addr = "rofi";
      }
      {
        rule = "blur";
        addr = "session";
      }
      {
        rule = "blur";
        addr = "shell:*";
      }
      {
        rule = "blur";
        addr = "sideleft";
      }
      {
        rule = "blur";
        addr = "sideright";
      }
      {
        rule = "blur";
        addr = "vicinae";
      }
      {
        rule = "ignorealpha 0";
        addr = "rofi";
      }
      {
        rule = "ignorealpha 0";
        addr = "vicinae";
      }
      {
        rule = "ignorealpha 0.5";
        addr = "launcher";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "bar";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "cheatsheet";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "corner.*";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "dock";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "indicator*";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "indicator.*";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "osk";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "overview";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "shell:*";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "sideleft";
      }
      {
        rule = "ignorealpha 0.6";
        addr = "sideright";
      }
      {
        rule = "ignorealpha 0.69";
        addr = "notifications";
      }
      {
        rule = "ignorezero";
        addr = "gtk-layer-shell";
      }
      {
        rule = "ignorezero";
        addr = "notifications";
      }
      {
        rule = "ignorezero";
        addr = "notifications";
      }
      {
        rule = "ignorezero";
        addr = "rofi";
      }
      {
        rule = "noanim";
        addr = "anyrun";
      }
      {
        rule = "noanim";
        addr = "hyprpicker";
      }
      {
        rule = "noanim";
        addr = "indicator.*";
      }
      {
        rule = "noanim";
        addr = "noanim";
      }
      {
        rule = "noanim";
        addr = "osk";
      }
      {
        rule = "noanim";
        addr = "overview";
      }
      {
        rule = "noanim";
        addr = "rofi";
      }
      {
        rule = "noanim";
        addr = "selection";
      }
      {
        rule = "noanim";
        addr = "vicinae";
      }
      {
        rule = "noanim";
        addr = "walker";
      }
      {
        rule = "xray 1";
        addr = ".*";
      }
    ];
  };

  exec-once = [
    "dbus-update-activation-environment --systemd --all"
    "hyprpm reload -n"
    "wl-paste --type image --watch cliphist store"
    "wl-paste --type text --watch cliphist store"
    "wlsunset -l 40.7 -L -73.9"
    "xrdb ~/.Xresources"
  ];

  exec = [ ];
}
