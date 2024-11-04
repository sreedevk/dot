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
              size      = 3
              passes    = 1
              vibrancy  = 0.1696
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
              natural_scroll  = false
          }
        }
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

        xwayland {
          force_zero_scaling = true
        }

        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

        dwindle {
            pseudotile     = true
            preserve_split = true
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
      '';
    };
  };
}
