{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "autobrr" = {
      autoStart = true;
      dependsOn = [
        "qbittorrent-nox"
      ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "ghcr.io/autobrr/autobrr:latest";
      ports = [
        "${opts.ports.autobrr}:7474"
      ];
      volumes = [
        "${opts.paths.application_data}/autobrr/:/config"
      ];
    };
  };
}
