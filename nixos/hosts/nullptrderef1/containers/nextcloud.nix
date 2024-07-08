{ config, lib, pkgs, secrets, opts, ... }: {
  autoStart = true;
  image = "nextcloud/all-in-one:latest";
  extraOptions = [
    "--add-host=nullptrderef1:${opts.lanAddress}"
    "--no-healthcheck"
    "--sig-proxy=false"
  ];
  ports = [
    "${opts.ports.nextcloud-http}:80"
    "${opts.ports.nextcloud-https}:8443"
    "${opts.ports.nextcloud-app}:8080"
  ];
  volumes = [
    "${opts.paths.podmanSocket}:/var/run/docker.sock:ro"
    "${opts.paths.application_data}/nextcloud:/mnt/docker-aio-config"
  ];

  environment = {
    TZ = opts.timeZone;
    PUID = opts.adminUID;
    PGID = opts.adminGID;
  };
}
