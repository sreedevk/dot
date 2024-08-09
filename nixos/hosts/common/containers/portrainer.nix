{ config, lib, pkgs, secrets, opts, ... }: {

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      portrainer_misc
      portrainer_web
      portrainer_web_secure
    ]);

  virtualisation.oci-containers.containers = {
    "portrainer" = {
      autoStart = true;
      image = "portainer/portainer-ce:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.portrainer_misc}:8000" "${opts.ports.portrainer_web_secure}:9443" "${opts.ports.portrainer_web}:9000" ];
      volumes = [
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
        "${opts.paths.application_data}/Portrainer:/data"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
