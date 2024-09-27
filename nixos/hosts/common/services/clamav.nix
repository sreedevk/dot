{ pkgs, opts, ... }:
{
  services.clamav = {
    package = pkgs.clamav;
    daemon = {
      enable = true;
      settings = { };
    };

    scanner = {
      enable = true;
      interval = "weekly";
      scanDirectories = [
        opts.paths.app_datafiles
      ];
    };

    updater = {
      enable = true;
      interval = "weekly";
      frequency = 12;
      settings = { };
    };

  };
}
