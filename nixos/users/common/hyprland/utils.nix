{
  genEnvs =
    envs: builtins.concatStringsSep "\n"
      (builtins.attrValues
        (builtins.mapAttrs (key: value: "env = ${key},${value}") envs));

  genExec =
    exectype: pgms: builtins.concatStringsSep "\n" (builtins.map (program: "${exectype} = ${program}") pgms);

  genKeyboardBinds = binds:
    builtins.concatStringsSep "\n" (builtins.map (bind: "bind = ${bind.mod}, ${bind.keys}, ${bind.dispatcher}, ${bind.args}") binds);

  genMouseBinds = binds:
    builtins.concatStringsSep "\n" (builtins.map (bind: "bindm = ${bind.mod}, ${bind.button}, ${bind.dispatcher}") binds);

  genWorkspaceRules =
    let
      genWorkspaceRule = ruleconf: "workspace = ${ruleconf.workspace_label},${builtins.concatStringsSep "," ruleconf.rules}";
    in
    ruleconfs: builtins.concatStringsSep "\n" (builtins.map genWorkspaceRule ruleconfs);

  genWindowRules =
    let
      genWindowRule = ruleconf: "windowrule = ${ruleconf.rule},${ruleconf.window_identifiers}";
    in
    ruleconfs: builtins.concatStringsSep "\n" (builtins.map genWindowRule ruleconfs);


  genLayerRules =
    let
      genLayerRule = ruleconf: "layerrule = ${ruleconf.rule},${ruleconf.addr}";
    in
    ruleconfs: builtins.concatStringsSep "\n" (builtins.map genLayerRule ruleconfs);

  genWindowv2Rules =
    let
      genWindowRule = ruleconf: "windowrulev2 = ${ruleconf.rule},${builtins.concatStringsSep "," ruleconf.window_identifiers}";
    in
    ruleconfs: builtins.concatStringsSep "\n" (builtins.map genWindowRule ruleconfs);

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
