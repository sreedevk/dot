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
    ".config/hypr/extra.conf" = {
      enable = true;
      text =
        let
          xwayland = utils.genNested "xwayland" hyprconf.xwayland;
          dwindle = utils.genNested "dwindle" hyprconf.dwindle;
          master = utils.genNested "master" hyprconf.master;
          misc = utils.genNested "misc" hyprconf.misc;
          parsedconfs = xwayland ++ dwindle ++ master ++ misc;
        in
        builtins.concatStringsSep "\n" (pkgs.lib.lists.flatten parsedconfs);
    };
  };
}
