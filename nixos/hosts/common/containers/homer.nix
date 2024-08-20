{ config, lib, pkgs, secrets, opts, ... }:
let
  homerConfigSrc = builtins.fetchGit {
    name = "homer";
    url = "https://gitea.nullptr.sh/nullptrderef1/homer";
    rev = "6486e7540293116459b07997d755ff35ac96368d";
    ref = "main";
    shallow = true;
  };
in
{

  environment.etc = {
    "homer" = {
      enable = true;
      source = homerConfigSrc;
    };
  };

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ homer ]);
  virtualisation.oci-containers.containers = {
    "homer" = {
      autoStart = true;
      image = "b4bz/homer:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "/etc/homer:/www/assets:ro"
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
