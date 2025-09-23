{
  pkgs,
  config,
  opts,
  ...
}:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
in
{
  home.file = {
    ".config/hypr/keybinds.conf" = {
      enable = true;
      text =
        let
          genMouseBinds =
            binds:
            builtins.concatStringsSep "\n" (
              builtins.map (bind: "bindm = ${bind.mod}, ${bind.button}, ${bind.dispatcher}") binds
            );

          genKeyboardBinds =
            binds:
            builtins.concatStringsSep "\n" (
              builtins.map (bind: "bind = ${bind.mod}, ${bind.keys}, ${bind.dispatcher}, ${bind.args}") binds
            );
        in
        builtins.concatStringsSep "\n" [
          (genKeyboardBinds hyprconf.binds.keyboard)
          (genMouseBinds hyprconf.binds.mouse)
        ];
    };
  };
}
