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
    ".config/hypr/rules.conf" = {
      enable = true;
      text =
        let
          genLayerRules =
            let
              genLayerRule = ruleconf: "layerrule = ${ruleconf.rule},${ruleconf.addr}";
            in
            ruleconfs: builtins.concatStringsSep "\n" (builtins.map genLayerRule ruleconfs);

          genWindowRules =
            let
              genWindowRule = ruleconf: "windowrule = ${ruleconf.rule},${ruleconf.window_identifiers}";
            in
            ruleconfs: builtins.concatStringsSep "\n" (builtins.map genWindowRule ruleconfs);

          genWindowv2Rules =
            let
              genWindowRule =
                ruleconf:
                "windowrulev2 = ${ruleconf.rule},${builtins.concatStringsSep "," ruleconf.window_identifiers}";
            in
            ruleconfs: builtins.concatStringsSep "\n" (builtins.map genWindowRule ruleconfs);

          genWorkspaceRules =
            let
              genWorkspaceRule =
                ruleconf: "workspace = ${ruleconf.workspace_label},${builtins.concatStringsSep "," ruleconf.rules}";
            in
            ruleconfs: builtins.concatStringsSep "\n" (builtins.map genWorkspaceRule ruleconfs);
        in
        builtins.concatStringsSep "\n" [
          (genLayerRules     hyprconf.rules.layer)
          (genWindowRules    hyprconf.rules.window)
          (genWindowv2Rules  hyprconf.rules.windowv2)
          (genWorkspaceRules hyprconf.rules.workspace)
        ];
    };
  };
}
