{ pkgs, ... }:
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
        "/mnt/dpool1/appdata/files"
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
