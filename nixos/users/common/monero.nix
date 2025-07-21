{ pkgs, config, username, ... }:
{
  home.packages = with pkgs; [ monero-cli ];

  systemd.user.tmpfiles.rules = [
    "d ${builtins.getEnv "HOME"}/.bitmonero 0755 ${username} ${username}"
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
            "${pkgs.monero-cli}/bin/monerod --config-file=${config.age.secrets.moneroconf.path} --data-dir=${builtins.getEnv "HOME"}/.bitmonero/"
          ];
        };
      };
    };
  };
}
