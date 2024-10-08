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
      interval = "daily";
      scanDirectories = [
        opts.paths.downloads
      ];
    };

    updater = {
      enable = true;
      interval = "weekly";
      frequency = 1;
      settings = { };
    };

  };
}
