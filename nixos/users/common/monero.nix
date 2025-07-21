{ pkgs, config, opts, ... }:
{
  home.packages = with pkgs; [ monero-cli ];

  systemd.user.tmpfiles.rules = [
    "d ${builtins.getEnv "HOME"}/.bitmonero 0755 ${opts.adminUID} ${opts.adminGID}"
  ];

  systemd.user = {
    services = {
      monerod = {
        Unit = {
          Description = "Monero Node";
          Documentation = "info:monerod man:monerod";
          After = [
            "network-online.target"
            "agenix.service"
          ];
          Wants = [
            "network-online.target"
            "agenix.service"
          ];
        };
        Service = {
          Type = "simple";
          ExecStart = [
            "${pkgs.monero-cli}/bin/monerod --non-interactive --config-file=${config.age.secrets.moneroconf.path} --data-dir=${builtins.getEnv "HOME"}/.bitmonero/ --rpc-bind-ip=${opts.addresses.tailscale.nullptrderef1}  --rpc-bind-port=18081 --restricted-rpc --confirm-external-bind"
          ];
        };
      };
    };
  };
}
