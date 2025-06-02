{ pkgs, opts, ... }:
let
  homerConfigDirectory = builtins.path {
    name = "homer-config";
    path = ../configurations/homer;
  };
in
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ homer ]);
  virtualisation.oci-containers.containers = {
    "homer" = {
      autoStart = true;
      image = "b4bz/homer:latest";
      dependsOn = [ "gitea-app" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${homerConfigDirectory}:/www/assets:ro"
      ];
      ports = [ "${opts.ports.homer}:8080" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
