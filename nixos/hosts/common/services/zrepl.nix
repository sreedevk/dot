{ config, pkgs, opts, system, ... }:
{
  services.zrepl = {
    enable = true;
    settings = {
      jobs = [
        {
          name = "snapjob";
          type = "snap";
          filesystems = {
            "dpool0/backups" = true;
            "dpool0/notes" = true;
            "dpool0/personal/documents" = true;
            "dpool0/personal/finances" = true;
            "dpool0/secrets" = true;
          };
          snapshotting = {
            type = "periodic";
            interval = "72h";
            prefix = "zrepl_snapjob_";
          };
          pruning = {
            keep = [{ type = "last_n"; count = 3; }];
          };
        }
      ];
    };
  };
}
