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
          dwindle     = utils.genNested "dwindle" hyprconf.dwindle;
          master      = utils.genNested "master" hyprconf.master;
          misc        = utils.genNested "misc" hyprconf.misc;
          scrolling   = utils.genNested "scrolling" hyprconf.scrolling;
          xwayland    = utils.genNested "xwayland" hyprconf.xwayland;

          parsedconfs = xwayland ++ dwindle ++ scrolling ++ master ++ misc;
        in
        builtins.concatStringsSep "\n" (pkgs.lib.lists.flatten parsedconfs);
    };
  };
}
