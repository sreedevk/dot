{ pkgs, opts, config, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ n8n-db n8n-app ]);

  virtualisation.oci-containers.containers = {
    n8n-db = {
      autoStart = true;
      image = "postgres:16";
      volumes = [ "n8n_db:/var/lib/postgresql/data" ];
      ports = [ "${opts.ports.n8n-db}:5432" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--health-cmd=/usr/bin/pg_isready -h ${opts.hostname} -U n8n_admin -d n8n"
        "--health-interval=10s"
        "--health-timeout=30s"
      ];
      environmentFiles = [ config.age.secrets.n8n_env.path ];
      environment = {
        TZ = opts.timeZone;
      };
    };
    n8n-app = {
      autoStart = true;
      image = "n8nio/n8n:latest";
      dependsOn = [ "n8n-db" ];
      volumes = [ "n8n_app:/home/node/.n8n" ];
      ports = [ "${opts.ports.n8n-app}:5678" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" ];
      environmentFiles = [ config.age.secrets.n8n_env.path ];
      environment = {
        TZ = opts.timeZone;
        GENERIC_TIMEZONE = opts.timeZone;
      };
    };
  };
}
