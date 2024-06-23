{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "photoprism" = {
      autoStart = true;
      image = "photoprism/photoprism";
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--privileged"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.application_data}/Photoprism/:/photoprism/storage"
        "${opts.paths.images}:/photoprism/originals"
      ];
      ports = [ "2342:2342" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        PHOTOPRISM_UPLOAD_NSFW = "true";
        PHOTOPRISM_ADMIN_PASSWORD = secrets.photoprism.password;
      };
    };
  };
}
