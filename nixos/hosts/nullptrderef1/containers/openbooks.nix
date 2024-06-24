{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "openbooks" = {
      autoStart = true;
      image = "evanbuss/openbooks";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.books}:/books" ];
      ports = [ "${opts.ports.openbooks}:80" ];
      cmd = [ "--persist" "--name='${opts.applicationUserName}'" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
