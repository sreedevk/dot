{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ memos ]);

  virtualisation.oci-containers.containers = {
    "memos" = {
      autoStart = true;
      ports = [ "${opts.ports.memos}:5230" ];
      image = "neosmemo/memos:stable";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.memos.http.parent_name" = "${opts.hostname}";
        "kuma.memos.http.name" = "Memos";
        "kuma.memos.http.url" = "http://${opts.lanAddress}:${opts.ports.memos}/healthz";
      };
      volumes = [
        "${opts.paths.application_data}/memos:/var/opt/memos"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
