{ ... }:
{
  services.zrepl = {
    enable = true;
    settings = {
      jobs = [
        {
          name = "snapjob";
          type = "snap";
          filesystems = {
            "dpool1/backups" = true;
            "dpool1/notes" = true;
            "dpool1/personal/documents" = true;
            "dpool1/personal/finances" = true;
            "dpool1/secrets" = true;
          };
          snapshotting = {
            type = "periodic";
            interval = "72h";
            prefix = "zrepl_snapjob_";
          };
          pruning = {
            keep = [
              {
                type = "last_n";
                count = 3;
              }
            ];
          };
        }
      ];
    };
  };
}
