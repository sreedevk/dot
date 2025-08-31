{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ memos ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/memos 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "memos" = {
      autoStart = true;
      ports = [ "${opts.ports.memos}:5230" ];
      image = "neosmemo/memos:stable";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.memos.http.parent_name" = "${opts.hostname}";
        "kuma.memos.http.name" = "Memos";
        "kuma.memos.http.url" = "http://${opts.lanAddress}:${opts.ports.memos}/healthz";
      };
      volumes = [
        "${opts.paths.app_datafiles}/memos:/var/opt/memos"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
