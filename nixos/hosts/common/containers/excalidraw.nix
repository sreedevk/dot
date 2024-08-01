{ opts, ... }:
{
  virtualisation.oci-containers.containers = {
    "excalidraw" = {
      autoStart = true;
      image = "excalidraw/excalidraw:latest";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.excalidraw}:80" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
