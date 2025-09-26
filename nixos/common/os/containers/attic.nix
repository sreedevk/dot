{
  pkgs,
  opts,
  config,
  ...
}:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt [
    opts.ports.atticd # 8070
    opts.ports.atticdb # 8071
  ];

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/attic 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    attic = {
      autoStart = true;
      image = "ghcr.io/zhaofengli/attic:latest";
      environmentFiles = [ config.age.secrets.attic_env.path ];
      ports = [ "${opts.ports.atticd}:8080" ];
      volumes = [
        "${config.age.secrets.attic_server_config_toml.path}:/attic/server.toml"
        "${opts.paths.app_datafiles}/attic:/attic/storage"
      ];
      dependsOn = [ "atticdb" ];
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      cmd = [
        "-f"
        "/attic/server.toml"
      ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
    atticdb = {
      autoStart = false;
      image = "postgres:17.6-alpine";
      ports = [ "${opts.ports.atticdb}:5432" ];
      volumes = [ "atticdb_data:/var/lib/postgresql/data" ];
      environmentFiles = [ config.age.secrets.attic_env.path ];
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
