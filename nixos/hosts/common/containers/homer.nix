{ config, lib, pkgs, opts, ... }:
let
  homerConfigSource = builtins.fetchGit {
    name = "homer";
    url = "https://git.external.nullptr.sh/nullptrderef1/homer";
    rev = "a7e5ab223baa9739eb6f986c1975f8c090270068";
    ref = "main";
    shallow = true;
  };
in
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ homer ]);

  environment.etc = {
    "homerconf" = {
      enable = true;
      source = homerConfigSource;
    };
  };

  systemd.services."podman-homer" = {
    restartTriggers = [ homerConfigSource ];
  };

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/homer 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "homer" = {
      autoStart = true;
      image = "b4bz/homer:latest";
      dependsOn = [ "gitea-app" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        # local src: "${opts.paths.app_datafiles}/homer:/www/assets"
        "/etc/homerconf:/www/assets:ro"
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
