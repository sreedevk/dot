{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ livebook_api livebook_http ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/livebook 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "livebook" = {
      autoStart = true;
      image = "ghcr.io/livebook-dev/livebook";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.livebook_http}:8080" "${opts.ports.livebook_api}:8081" ];
      volumes = [ "${opts.paths.app_datafiles}/livebook:/data" ];
      environmentFiles = [ config.age.secrets.livebook_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
