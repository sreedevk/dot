{ pkgs, opts, ... }:
{
  services.clamav = {
    package = pkgs.clamav;
    daemon = {
      enable = opts.autostart-non-essential-services;
      settings = { };
    };

    scanner = {
      enable = opts.autostart-non-essential-services;
      interval = "daily";
      scanDirectories = [
        opts.paths.downloads
      ];
    };

    updater = {
      enable = opts.autostart-non-essential-services;
      interval = "weekly";
      frequency = 1;
      settings = { };
    };

  };
}
