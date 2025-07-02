{ pkgs, config, ... }:
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
          };
          Service = {
            Type = "simple";
            ExecStartPre = "/bin/sh -c 'export RAD_PASSPHRASE=\"$(cat ${config.age.secrets.radicle_passphrase.path})\"'";
            ExecStart = "${pkgs.radicle-node}/bin/rad node start --foreground";
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      };
    };
}
