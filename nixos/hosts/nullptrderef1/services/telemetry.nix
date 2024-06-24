{ config, pkgs, secrets, opts, ... }: {
  services.netdata = {
    enable = true;
    config = {
      global = {
        "update every" = 15;
      };
      ml = {
        "enabled" = "yes";
      };
    };
    configDir = {
      "stream.conf" = pkgs.writeText "stream.conf" ''
        [stream]
          enabled = yes
          destination = nullptrderef1:19999
          api key = ${secrets.netdata.api_key}
        [UUID]
          enabled = yes
      '';
    };
  };

  services.prometheus = {
    enable = true;
    port = 9001;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "systemd"
          "zfs"
        ];
        port = 9002;
        openFirewall = true;
      };
    };
    scrapeConfigs = [
      {
        job_name = "nullptrderef1";
        static_configs = [{
          targets = [ "0.0.0.0:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      security = {
        admin_password = "$__file{${pkgs.writeText "grafpass" secrets.grafana.password}}";
      };
      server = {
        domain = "nullptrderef1";
        protocol = "http";
        http_port = pkgs.lib.strings.toInt opts.ports.grafana;
        http_addr = "0.0.0.0";
      };
    };
  };
}
