{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ docuseal ]);

  virtualisation.oci-containers.containers = {
    "docuseal" = {
      autoStart = true;
      image = "docuseal/docuseal";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.docuseal}:3000" ];
      volumes = [ "${opts.paths.application_data}/docuseal:/data" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.docuseal.http.parent_name" = "${opts.hostname}";
        "kuma.docuseal.http.name" = "Docuseal";
        "kuma.docuseal.http.url" = "http://${opts.lanAddress}:${opts.ports.docuseal}/up";
      };
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
