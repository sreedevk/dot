{ pkgs, config, opts, ... }:
let
  hyprconf = import ./opts.nix { inherit pkgs config opts; };
  utils = import ./utils.nix;
in
{
  imports = [
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar
  ];

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
      text =
        builtins.concatStringsSep "\n"
          [
            (utils.genKeyboardBinds hyprconf.binds.keyboard)
            (utils.genMouseBinds hyprconf.binds.mouse)
          ];
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

    ".config/hypr/rules.conf" = {
      enable = true;
      text =
        builtins.concatStringsSep "\n"
          [
            (utils.genLayerRules hyprconf.rules.layer)
            (utils.genWindowRules hyprconf.rules.window)
            (utils.genWindowv2Rules hyprconf.rules.windowv2)
            (utils.genWorkspaceRules hyprconf.rules.workspace)
          ];
    };

    ".config/hypr/general.conf" = {
      enable = true;
      text = builtins.concatStringsSep "\n" (utils.genNested "general" hyprconf.general);
    };

    ".config/hypr/cursor.conf" = {
      enable = true;
      text = ''
        cursor:no_hardware_cursors = true
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
              enabled            = true
              noise              = 0.01
              special            = false
              new_optimizations  = true
              brightness         = 1
              xray               = true
              size               = 3
              passes             = 4
              vibrancy           = 0.1696
              popups             = true
              contrast           = 1
              popups_ignorealpha = 0.6
            }
        }
      '';
    };

    ".config/hypr/animations.conf" = {
      enable = true;
      text = ''
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
          tablet {
            transform = 2
          }
        }

        gestures {
          workspace_swipe = true
          workspace_swipe_distance = 300
          workspace_swipe_fingers = 3
          workspace_swipe_cancel_ratio = 0.5
          workspace_swipe_min_speed_to_force = 5
          workspace_swipe_direction_lock = true
          workspace_swipe_direction_lock_threshold = 10
          workspace_swipe_create_new = true
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
        source = ~/.config/hypr/rules.conf

        xwayland {
          force_zero_scaling = true
        }

        dwindle {
            pseudotile     = true
            preserve_split = true
        }

        master {
            mfact = 0.70
        }

        misc {
            force_default_wallpaper = 0
            disable_hyprland_logo   = true
            vrr = 0
        }

        gestures {
            workspace_swipe = false
        }

        device {
            name        = epic mouse v1
            sensitivity = -0.5
        }
      '';
    };
  };
}
