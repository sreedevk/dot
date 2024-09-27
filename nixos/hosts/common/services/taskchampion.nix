{ config, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      taskchampion
    ]);

  systemd.services.taskchampion-sync = {
    description = "taskwarrior task server";
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.taskchampion-sync-server}/bin/taskchampion-sync-server --port ${opts.ports.taskchampion} --data-dir ${opts.paths.app_datafiles}/TaskChampion
      '';
      Restart = "always";
    };
  };
}
