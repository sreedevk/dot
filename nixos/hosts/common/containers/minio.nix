{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ minio-console minio-api ]);

  virtualisation.oci-containers.containers = {
    minio = {
      autoStart = true;
      image = "quay.io/minio/minio";
      environmentFiles = [ config.age.secrets.minio_env.path ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/MinIO:/mnt/data"
        "${config.age.secrets.minio_env.path}:/etc/config.env"
      ];
      cmd = [ "server" "--console-address=:9001" ];
      ports = [
        "${opts.ports.minio-console}:9001"
        "${opts.ports.minio-api}:9000"
      ];
      environment = {
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
    };
  };
}
