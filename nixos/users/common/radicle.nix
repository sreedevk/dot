{ pkgs, config, ... }:
let
  preExecScript =
    ''
      /bin/sh -c '\
      set -euo pipefail; \
      while [ ! -f "${config.age.secrets.radicle_passphrase.path}" ]; do \
        sleep 1; \
      done; \
      export RAD_PASSPHRASE="$(cat ${config.age.secrets.radicle_passphrase.path})"'
    '';
in
{
  home.packages = with pkgs; [
    radicle-httpd
    radicle-node
  ];

  systemd.user =
    {
      services = {
        radicle-node = {
          Unit = {
            Description = "Radicle Node Runner";
            Documentation = "info:rad man:rad(1) https://radicle.xyz/guides/user";
            After = [ "agenix.service" ];
            Requires = [ "agenix.service" ];
          };
          Service = {
            Type = "simple";
            ExecStartPre = preExecScript;
            ExecStart = "${pkgs.radicle-node}/bin/rad node start --foreground";
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      };
    };
}
