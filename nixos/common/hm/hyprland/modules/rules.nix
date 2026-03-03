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
              genLayerRule = ruleconf: "layerrule = ${ruleconf.rule},match:namespace ${ruleconf.addr}";
            in
            ruleconfs: builtins.concatStringsSep "\n" (builtins.map genLayerRule ruleconfs);

          genWindowRules =
            let
              genWindowRule =
                ruleconf:
                "windowrule = ${ruleconf.rule},${builtins.concatStringsSep "," ruleconf.window_identifiers}";
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
          (genWorkspaceRules hyprconf.rules.workspace)
        ];
    };
  };
}
