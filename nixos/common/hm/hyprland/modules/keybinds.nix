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
            let
              bindArgAppend = arg: 
                (if arg == null then "" else ", ${arg}");
            in
            binds:
            builtins.concatStringsSep "\n" (
              builtins.map (bind: "bindm = ${bind.mod}, ${bind.button}, ${bind.dispatcher}${bindArgAppend bind.args}") binds
            );

          genKeyboardBinds =
            let
              bindArgAppend = arg: 
                (if arg == null then "" else ", ${arg}");
            in
            binds:
            builtins.concatStringsSep "\n" (
              builtins.map (bind: "bind = ${bind.mod}, ${bind.keys}, ${bind.dispatcher}${bindArgAppend bind.args}") binds
            );
        in
        builtins.concatStringsSep "\n" [
          (genKeyboardBinds hyprconf.binds.keyboard)
          (genMouseBinds hyprconf.binds.mouse)
        ];
    };
  };
}
