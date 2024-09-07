{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      portainer_misc
      portainer_web
      portainer_web_secure
    ]);

  virtualisation.oci-containers.containers = {
    "portainer" = {
      autoStart = true;
      image = "portainer/portainer-ce:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.portainer_misc}:8000" "${opts.ports.potrainer_web_secure}:9443" "${opts.ports.potrainer_web}:9000" ];
      volumes = [
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
        "${opts.paths.application_data}/Portainer:/data"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
