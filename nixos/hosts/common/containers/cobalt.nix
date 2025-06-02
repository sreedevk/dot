{ opts, ... }:
let
  cobalt_cookies_conf = builtins.toJSON { };
in
{
  systemd.tmpfiles.rules = [
    "d ${opts.paths.downloads}/Cobalt                   0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/cobalt               0755 ${opts.adminUID} ${opts.adminGID} -"
    "f ${opts.paths.app_datafiles}/cobalt/cookies.json  0755 ${opts.adminUID} ${opts.adminGID} - ${cobalt_cookies_conf}"
  ];

  virtualisation.oci-containers.containers = {
    cobalt = {
      image = "ghcr.io/imputnet/cobalt:11";
      autoStart = opts.autostart-non-essential-services;
      user = "${opts.adminUID}:${opts.adminGID}";
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
          "--init"
          "--read-only"
        ];
      ports = [ "${opts.ports.cobalt}:9000/tcp" ];
      labels = [ "com.centurylinklabs.watchtower.scope=cobalt" ];
      volumes = [ "${opts.app_datafiles}/cobalt/cookies.json:/cookies.json" ];
      environment = {
        API_URL = "https://api.cobalt.nullptr.sh/";
        COOKIE_PATH = "/cookies.json";
      };
    };
  };
}
