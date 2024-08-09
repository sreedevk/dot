{ config, lib, pkgs, secrets, opts, ... }: {

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      nginx-proxy-manager-app
      nginx-proxy-manager-http
      nginx-proxy-manager-https
    ]);

  virtualisation.oci-containers.containers = {
    "nginx-proxy-manager" = {
      autoStart = false;
      image = "jc21/nginx-proxy-manager:latest";
      ports = [
        "${opts.ports.nginx-proxy-manager-app}:81"
        "${opts.ports.nginx-proxy-manager-http}:80"
        "${opts.ports.nginx-proxy-manager-https}:443"
      ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" "--privileged" ];
      volumes = [
        "${opts.paths.application_data}/nginx-proxy-manager:/data"
        "${opts.paths.application_data}/letsencrypt:/etc/letsencrypt"
      ];
    };
  };
}
