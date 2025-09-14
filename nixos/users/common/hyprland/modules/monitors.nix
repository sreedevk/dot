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
    ".config/hypr/monitors.conf" = {
      enable = true;
      text =
        let
          genMonitors =
            monitors:
            let
              genMonitor =
                monitor:
                let
                  res = "${builtins.toString monitor.resolution.x}x${builtins.toString monitor.resolution.y}";
                  position = "${builtins.toString monitor.position.x}x${builtins.toString monitor.position.y}";
                  rate = builtins.toString monitor.rate;
                  scale = builtins.toString monitor.scale;
                  bitdepth =
                    if (builtins.typeOf (monitor.bitdepth or null)) == "int" then
                      [ "bitdepth,${builtins.toString monitor.bitdepth}" ]
                    else
                      [ ];

                  rhs = builtins.concatStringsSep "," (
                    [
                      "desc:${monitor.desc}"
                      "${res}@${rate}"
                      position
                      scale
                    ]
                    ++ bitdepth
                  );
                in
                "monitor = ${rhs}";
            in
            builtins.concatStringsSep "\n" (builtins.map genMonitor monitors);
        in
        genMonitors hyprconf.monitors;
    };
  };
}
