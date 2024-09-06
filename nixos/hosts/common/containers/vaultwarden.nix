{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      vaultwarden
    ]);

  virtualisation.oci-containers.containers = {
    "vaultwarden" = {
      autoStart = true;
      image = "vaultwarden/server:latest ";
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.vw.http.parent_name" = "${opts.hostname}";
        "kuma.vw.http.name" = "VaultWarden";
        "kuma.vw.http.url" = "http://${opts.lanAddress}:${opts.ports.vaultwarden}/alive";
      };
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.vaultwarden}:80" ];
      volumes = [ "${opts.paths.application_data}/vw-data:/data/" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
