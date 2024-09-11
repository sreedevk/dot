{ opts, config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ http https nginx-proxy-manager ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ http https nginx-proxy-manager ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.application_data}/tailscale-nginx/state 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {

    "tailscale-nginx" = {
      autoStart = true;
      image = "tailscale/tailscale:latest";
      hostname = "tailscale-nginx";
      volumes = [
        "${opts.paths.application_data}/tailscale-nginx/state:/var/lib/tailscale"
        "/dev/net/tun:/dev/net/tun"
      ];
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--cap-add=SYS_MODULE"
        "--privileged"
        "--add-host=${opts.hostname}:${opts.lanAddress}"
      ];
      environmentFiles = [ config.age.secrets.tailscale_nginx_env.path ];
      environment = {
        TS_EXTRA_ARGS = "--advertise-exit-node --advertise-tags=tag:container"; # 
        TS_STATE_DIR = "/var/lib/tailscale";
        TS_USERSPACE = "false";
        TZ = opts.timeZone;
      };
    };

    "nginx-proxy-manager" = {
      autoStart = true;
      dependsOn = [ "tailscale-nginx" ];
      image = "jc21/nginx-proxy-manager:latest";
      extraOptions = [
        "--network=container:tailscale-nginx"
        "--privileged"
        "--no-healthcheck"
      ];
      ports = [
        "${opts.ports.http}:80"
        "${opts.ports.nginx-proxy-manager}:81"
        "${opts.ports.https}:443"
      ];
      environment = {
        TZ = opts.timeZone;
      };
      volumes = [
        "${opts.paths.application_data}/NginxProxyManager:/data"
        "${opts.paths.application_data}/LetsEncrypt:/etc/letsencrypt"
      ];
    };

  };
}
