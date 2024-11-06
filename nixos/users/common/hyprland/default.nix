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
        let
          reduce = x: if builtins.typeOf (x) == "string" then x else builtins.concatStringsSep "\n" x;
        in
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

    ".config/hypr/inputs.conf" = {
      enable = true;
      text =
        let
          inputs = utils.flattenList (utils.genNested "input" hyprconf.inputs);
          gestures = utils.flattenList (utils.genNested "gestures" hyprconf.gestures);
        in
        builtins.concatStringsSep "\n" (inputs ++ gestures);
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
        animations {
          enabled = true
          bezier = linear, 0, 0, 1, 1
          bezier = md3_standard, 0.2, 0, 0, 1
          bezier = md3_decel, 0.05, 0.7, 0.1, 1
          bezier = md3_accel, 0.3, 0, 0.8, 0.15
          bezier = overshot, 0.05, 0.9, 0.1, 1.1
          bezier = crazyshot, 0.1, 1.5, 0.76, 0.92 
          bezier = hyprnostretch, 0.05, 0.9, 0.1, 1.0
          bezier = menu_decel, 0.1, 1, 0, 1
          bezier = menu_accel, 0.38, 0.04, 1, 0.07
          bezier = easeInOutCirc, 0.85, 0, 0.15, 1
          bezier = easeOutCirc, 0, 0.55, 0.45, 1
          bezier = easeOutExpo, 0.16, 1, 0.3, 1
          bezier = softAcDecel, 0.26, 0.26, 0.15, 1
          bezier = md2, 0.4, 0, 0.2, 1 # use with .2s duration
          animation = windows, 1, 3, md3_decel, popin 60%
          animation = windowsIn, 1, 3, md3_decel, popin 60%
          animation = windowsOut, 1, 3, md3_accel, popin 60%
          animation = border, 1, 10, default
          animation = fade, 1, 3, md3_decel
          animation = layersIn, 1, 3, menu_decel, slide
          animation = layersOut, 1, 1.6, menu_accel
          animation = fadeLayersIn, 1, 2, menu_decel
          animation = fadeLayersOut, 1, 4.5, menu_accel
          animation = workspaces, 1, 7, menu_decel, slide
          animation = specialWorkspace, 1, 3, md3_decel, slidevert
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
