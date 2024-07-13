{ pkgs, config, opts, secrets, ... }:
{
  # container-registry-web
  virtualisation.oci-containers.containers = {
    "container-registry-server" = {
      autoStart = true;
      image = "registry:2.7";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.container-registry-server}:5000" ];
      volumes = [ "${opts.paths.application_data}/containers/server:/var/lib/registry" ];
      environment = {
        REGISTRY_HTTP_SECRET = secrets.registry_http_secret;
        TZ = opts.timeZone;
        USER_GID = opts.adminGID;
        USER_UID = opts.adminUID;
      };
    };

    "container-registry-web" = {
      autoStart = true;
      dependsOn = [ "container-registry-server" ];
      image = "quiq/registry-ui";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" "--privileged" ];
      ports = [ "${opts.ports.container-registry-web}:8000" ];
      volumes = [
        "${opts.paths.application_data}/containers/web/data:/opt/data"
        "${opts.paths.application_data}/containers/web/config.yml:/opt/config.yml:ro"
      ];
      environment = {
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
    };
  };
}
