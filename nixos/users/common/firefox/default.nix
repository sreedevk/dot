{ pkgs, config, firefox-addons, system, ... }:
let
  extensions = import ./extensions.nix { inherit firefox-addons system; };
  settings = import ./settings.nix;
  searchEngines = import ./search-engines.nix;
  bookmarks = import ./bookmarks.nix;
  containers = import ./containers.nix;
in
{
  programs.firefox = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.firefox-bin;
    profiles = {

      main = {
        isDefault = true;
        id = 0;
        containersForce = false;
        containers = containers;
        extensions = {
          packages = extensions;
        };
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
          engines = searchEngines;
        };
        settings = settings;
        bookmarks = bookmarks;
      };

    };
  };
}
