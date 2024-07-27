{ config, pkgs, opts, ... }: {
  systemd.services.taskchampion-sync = {
    description = "taskwarrior task server";
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.taskchampion-sync-server}/bin/taskchampion-sync-server --port ${opts.ports.taskchampion} --data-dir ${opts.paths.application_data}/TaskChampion
      '';
      Restart = "always";
    };
  };
}
