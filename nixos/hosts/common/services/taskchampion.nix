{ config, nixpkgs-stable, pkgs, opts, ... }: {
  environment.systemPackages = with pkgs; [
    taskchampion-sync-server
  ];

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
        ${nixpkgs-stable.taskchampion-sync-server}/bin/taskchampion-sync-server --port ${opts.ports.taskchampion} --data-dir ${opts.paths.application_data}/TaskChampion
      '';
      Restart = "always";
    };
  };
}
