{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ minio-console minio-api ]);

  virtualisation.oci-containers.containers = {
    minio = {
      autoStart = true;
      image = "minio/minio:latest";
      environmentFiles = [ config.age.secrets.minio_env.path ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "minio_data:/data"
        "${config.age.secrets.minio_env.path}:/etc/config.env"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.minio.http.parent_name" = "${opts.hostname}";
        "kuma.minio.http.name" = "MinIO";
        "kuma.minio.http.url" = "http://${opts.lanAddress}:${opts.ports.minio-api}/minio/health/live";
      };
      cmd = [ "server" "--console-address=:16000" "--address=:17000" ];
      ports = [
        "${opts.ports.minio-console}:16000"
        "${opts.ports.minio-api}:17000"
      ];
      environment = {
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
    };
  };
}
