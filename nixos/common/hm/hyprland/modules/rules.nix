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
        with builtins;
        let
          genLayerRules =
            let
              genLayerRule =
                ruleconf:
                concatStringsSep "\n" (
                  map (rule: "layerrule = match:namespace ${ruleconf.addr}, ${rule}") ruleconf.rules
                );
            in
            ruleconfs: concatStringsSep "\n" (map genLayerRule ruleconfs);

          genWindowRules =
            let
              genWindowRule =
                ruleconf:
                concatStringsSep "\n" (
                  map (rule: "windowrule = ${concatStringsSep "," ruleconf.addr},${rule}") ruleconf.rules
                );
            in
            ruleconfs: concatStringsSep "\n" (map genWindowRule ruleconfs);

          genWorkspaceRules =
            let
              genWorkspaceRule =
                ruleconf: "workspace = ${ruleconf.workspace_label},${concatStringsSep "," ruleconf.rules}";
            in
            ruleconfs: concatStringsSep "\n" (map genWorkspaceRule ruleconfs);
        in
        concatStringsSep "\n" [
          (genLayerRules hyprconf.rules.layer)
          (genWindowRules hyprconf.rules.window)
          (genWorkspaceRules hyprconf.rules.workspace)
        ];
    };
  };
}
