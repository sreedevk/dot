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
    ".config/hypr/envs.conf" = {
      enable = true;
      text =
        let
          genEnvs =
            envs:
            builtins.concatStringsSep "\n" (
              builtins.attrValues (builtins.mapAttrs (key: value: "env = ${key},${value}") envs)
            );
        in
        genEnvs hyprconf.envs;
    };
  };
}
