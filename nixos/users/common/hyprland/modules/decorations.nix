{ pkgs
, config
, opts
, ...
}:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/decoration.conf" = {
      enable = true;
      text = builtins.concatStringsSep "\n" (
        utils.flattenList (utils.genNested "decoration" hyprconf.decoration)
      );
    };
  };
}
