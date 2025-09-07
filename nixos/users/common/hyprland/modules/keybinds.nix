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
    ".config/hypr/keybinds.conf" = {
      enable = true;
      text = builtins.concatStringsSep "\n" [
        (utils.genKeyboardBinds hyprconf.binds.keyboard)
        (utils.genMouseBinds hyprconf.binds.mouse)
      ];
    };
  };
}
