{
  genEnvs =
    envs: builtins.concatStringsSep "\n"
      (builtins.attrValues
        (builtins.mapAttrs (key: value: "env = ${key},${value}") envs));

  genExec =
    exectype: pgms: builtins.concatStringsSep "\n" (builtins.map (program: "${exectype} = ${program}") pgms);

  genBinds = binds:
    builtins.concatStringsSep "\n" (builtins.map (bind: "bind = ${bind.mod}, ${bind.keys}, ${bind.dispatcher}, ${bind.args}") binds);

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
          rhs = builtins.concatStringsSep ", " [ "desc:${monitor.desc}" "${res}@${rate}" position scale ];
        in
        "monitor = ${rhs}";
    in
    builtins.concatStringsSep "\n" (builtins.map genMonitor monitors);
}
