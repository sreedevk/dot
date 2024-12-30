{ pkgs, lib, config, firefox-addons, system, ... }:
let
  nixglmod = import ../nixGL.nix { inherit lib config pkgs; };
  extensions = import ./extensions.nix { inherit firefox-addons system; };

  settings = import ./settings.nix;
  searchEngines = import ./search-engines.nix;
  bookmarks = import ./bookmarks.nix;
  containers = import ./containers.nix;
in
{
  stylix.targets.firefox.enable = true;
  programs.firefox = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.firefox-bin "firefox";
    profiles = {

      main = {
        isDefault = true;
        id = 0;
        containersForce = false;
        containers = { };
        extensions = extensions;
        search = {
          force = true;
          default = "Brave";
          privateDefault = "Brave";
          engines = searchEngines;
        };
        settings = settings;
        bookmarks = bookmarks;
      };

    };
  };
}
