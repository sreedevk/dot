{ pkgs, config, opts, ... }:
let
  hyprconf = import ./opts.nix { inherit pkgs config opts; };
  utils = import ./utils.nix;
in
{
  imports = [ ../waybar ../hyprpaper.nix ];

  home.file = {
    ".config/hypr/monitors.conf" = {
      enable = true;
      text = utils.genMonitors hyprconf.monitors;
    };

    ".config/hypr/envs.conf" = {
      enable = true;
      text = utils.genEnvs hyprconf.envs;
    };

    ".config/hypr/keybinds.conf" = {
      enable = true;
      text = utils.genBinds hyprconf.binds;
    };

    ".config/hypr/execs.conf" = {
      enable = true;
      text =
        builtins.concatStringsSep "\n"
          [
            (utils.genExec "exec-once" hyprconf.exec-once)
            (utils.genExec "exec" hyprconf.exec)
          ];
    };

    ".config/hypr/general.conf" = {
      enable = true;
      text = ''
        general {
          gaps_in             = 5
          gaps_out            = 10
          border_size         = 2
          resize_on_border    = false
          allow_tearing       = false
          layout              = master
          col.active_border   = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
        }
      '';
    };

    ".config/hypr/cursor.conf" = {
      enable = true;
      text = ''
        cursor {
            no_hardware_cursors = true
        }
      '';
    };

    ".config/hypr/decoration.conf" = {
      enable = true;
      text = ''
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
              noise = 0.01
              special = false
              new_optimizations = true
              brightness = 1
              xray      = true
              size      = 6
              passes    = 4
              vibrancy  = 0.1696
              popups = true
              contrast = 1
              popups_ignorealpha = 0.6
            }
        }
      '';
    };

    ".config/hypr/animations.conf" = {
      enable = true;
      text = ''
        animations {
            enabled   = true
            bezier    = myBezier, 0.05, 0.9, 0.1, 1.05
            animation = windows, 1, 6, myBezier
            animation = windowsOut, 1, 6, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 5, default
            animation = workspaces, 1, 2, default
        }
      '';
    };

    ".config/hypr/inputs.conf" = {
      enable = true;
      text = ''
        input {
          kb_layout           = us
          kb_variant          =
          kb_model            =
          kb_options          = ctrl:nocaps
          kb_rules            =
          follow_mouse        = 1
          sensitivity         = 0
          touchpad {
            natural_scroll       = yes
            disable_while_typing = true
            clickfinger_behavior = true
          }
        }

        gestures {
          workspace_swipe = true
          workspace_swipe_distance = 700
          workspace_swipe_fingers = 4
          workspace_swipe_cancel_ratio = 0.2
          workspace_swipe_min_speed_to_force = 5
          workspace_swipe_direction_lock = true
          workspace_swipe_direction_lock_threshold = 10
          workspace_swipe_create_new = true
        }
      '';
    };

    ".config/hypr/rules.conf" = {
      enable = true;
      text = ''
        windowrule   = center, title:^(Open File)(.*)$
        windowrule   = center, title:^(Select a File)(.*)$
        windowrule = center, title:^(Choose wallpaper)(.*)$
        windowrule = center, title:^(File Upload)(.*)$
        windowrule = center, title:^(Library)(.*)$
        windowrule = center, title:^(Open Folder)(.*)$
        windowrule = center, title:^(Save As)(.*)$
        windowrule = float, ^(blueberry.py)$
        windowrule = float, ^(guifetch)$ # FlafyDev/guifetch
        windowrule = float, ^(steam)$
        windowrulev2 = float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = tile, class:(dev.warp.Warp)
        windowrulev2 = keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = move 73% 72%,title:^(Picture(-| )in(-| )[Pp]icture)$ 
        windowrulev2 = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = float, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = pin, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrule=float,title:^(Open File)(.*)$
        windowrule=float,title:^(Select a File)(.*)$
        windowrule=float,title:^(Choose wallpaper)(.*)$
        windowrule=float,title:^(Open Folder)(.*)$
        windowrule=float,title:^(Save As)(.*)$
        windowrule=float,title:^(Library)(.*)$
        windowrule=float,title:^(File Upload)(.*)$
        windowrule=immediate,.*\.exe
        windowrulev2=immediate,class:(steam_app)
        windowrulev2 = noshadow,floating:0
        layerrule = xray 1, .*
        layerrule = noanim, walker
        layerrule = noanim, selection
        layerrule = noanim, overview
        layerrule = noanim, anyrun
        layerrule = noanim, indicator.*
        layerrule = noanim, osk
        layerrule = noanim, hyprpicker
        layerrule = blur, shell:*
        layerrule = ignorealpha 0.6, shell:*
        layerrule = noanim, noanim
        layerrule = blur, gtk-layer-shell
        layerrule = ignorezero, gtk-layer-shell
        layerrule = blur, launcher
        layerrule = ignorealpha 0.5, launcher
        layerrule = blur, notifications
        layerrule = ignorealpha 0.69, notifications
        layerrule = animation slide left, sideleft.*
        layerrule = animation slide right, sideright.*
        layerrule = blur, session
        layerrule = blur, bar
        layerrule = ignorealpha 0.6, bar
        layerrule = blur, corner.*
        layerrule = ignorealpha 0.6, corner.*
        layerrule = blur, dock
        layerrule = ignorealpha 0.6, dock
        layerrule = blur, indicator.*
        layerrule = ignorealpha 0.6, indicator.*
        layerrule = blur, overview
        layerrule = ignorealpha 0.6, overview
        layerrule = blur, cheatsheet
        layerrule = ignorealpha 0.6, cheatsheet
        layerrule = blur, sideright
        layerrule = ignorealpha 0.6, sideright
        layerrule = blur, sideleft
        layerrule = ignorealpha 0.6, sideleft
        layerrule = blur, indicator*
        layerrule = ignorealpha 0.6, indicator*
        layerrule = blur, osk
        layerrule = ignorealpha 0.6, osk
      '';
    };

    ".config/hypr/hyprland.conf" = {
      enable = true;
      text = ''
        source = ~/.config/hypr/monitors.conf
        source = ~/.config/hypr/envs.conf
        source = ~/.config/hypr/keybinds.conf
        source = ~/.config/hypr/execs.conf
        source = ~/.config/hypr/general.conf
        source = ~/.config/hypr/cursor.conf
        source = ~/.config/hypr/decoration.conf
        source = ~/.config/hypr/animations.conf
        source = ~/.config/hypr/inputs.conf
        source = ~/.config/hypr/rules.conf

        xwayland {
          force_zero_scaling = true
        }

        dwindle {
            pseudotile     = true
            preserve_split = true
        }

        master {
            new_status = master
            mfact = 0.70
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
      '';
    };
  };
}
