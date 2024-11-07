{ pkgs, config, opts, ... }:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
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
  };
}
