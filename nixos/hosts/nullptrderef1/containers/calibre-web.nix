{ pkgs, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    calibre-web = {
      autoStart = true;
      image = "linuxserver/calibre-web";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.calibre-web}:8083" ];
      volumes = [
        "${opts.paths.application_data}/calibre-web:/config"
        "${opts.paths.books}:/books:ro"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        DOCKER_MODS = "linuxserver/mods:universal-calibre";
        OAUTHLIB_RELAX_TOKEN_SCOPE = "1";
      };
    };
  };
}
