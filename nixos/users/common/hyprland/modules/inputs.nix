{ pkgs, config, opts, ... }:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/inputs.conf" = {
      enable = true;
      text =
        let
          inputs = utils.flattenList (utils.genNested "input" hyprconf.inputs);
          gestures = utils.flattenList (utils.genNested "gestures" hyprconf.gestures);
        in
        builtins.concatStringsSep "\n" (inputs ++ gestures);
    };
  };
}
