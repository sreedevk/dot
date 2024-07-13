{ pkgs, config, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    "container-registry" = {
      autoStart = true;
      image = "registry:2";
      extraOptions = [ "--network=host" "--no-healthcheck" ];
      ports = [ "${opts.ports.container-registry}:5000" ];
      volumes = [ "${opts.paths.application_data}/container-registry:/data" ];
      environment = {
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/data";
      };
    };
  };
}
