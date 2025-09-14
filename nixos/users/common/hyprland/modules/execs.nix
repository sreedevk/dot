{ pkgs
, config
, opts
, ...
}:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
in
{
  home.file = {
    ".config/hypr/execs.conf" = {
      enable = true;
      text =
        let
          genExec =
            exectype: pgms:
            builtins.concatStringsSep "\n" (builtins.map (program: "${exectype} = ${program}") pgms);
        in
        builtins.concatStringsSep "\n" [
          (genExec "exec-once" hyprconf.exec-once)
          (genExec "exec" hyprconf.exec)
        ];
    };
  };
}
