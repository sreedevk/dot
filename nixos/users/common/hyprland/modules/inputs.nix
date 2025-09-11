{
  pkgs,
  config,
  opts,
  ...
}:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/inputs.conf" = {
      enable = true;
      text = builtins.concatStringsSep "\n" (utils.flattenList (utils.genNested "input" hyprconf.inputs));
    };
    ".config/hypr/gestures.conf" = {
      enable = true;
      text =
        utils.genGestures hyprconf.gestures;
    };
  };
}
