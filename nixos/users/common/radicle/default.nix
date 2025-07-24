{ pkgs, username, opts, config, ... }:
let
  radconf = import ./configs.nix;
  radnode = pkgs.writeShellScriptBin "radnode" ''
    export RAD_PASSPHRASE="$(${pkgs.coreutils}/bin/cat ${config.age.secrets.radicle_passphrase.path})"
    ${pkgs.radicle-node}/bin/rad node start --foreground
  '';
in
{
  home.packages = with pkgs; [
    radicle-httpd
    radicle-node
  ];

  home.file = {
    ".radicle/config.json" = {
      enable = true;
      text = radconf."${username}@${opts.hostname}";
    };
  };

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
            ExecStart = "${radnode}/bin/radnode";
            Restart = "on-failure";
            RestartSec = "10s";
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      };
    };
}
