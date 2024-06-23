{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "kavita" = {
      autoStart = true;
      image = "jvmilazz0/kavita";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${secrets.kavita.app.port}:5000" ];
      volumes = [
        "${opts.paths.application_data}/kavita:/kavita/config"
        "${opts.paths.books}:/books"
        "${opts.paths.magazines}:/magazines"
      ];

      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
