{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ntfy ]);

  virtualisation.oci-containers.containers = {
    "ntfy" = {
      autoStart = true;
      image = "binwiederhier/ntfy";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      cmd = [ "serve" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      ports = [ "${opts.ports.ntfy}:80" ];
      volumes = [
        "${opts.paths.application_data}/ntfy/cache:/var/cache/ntfy"
        "${opts.paths.application_data}/ntfy/data/:/etc/ntfy"
      ];
    };
  };
}
