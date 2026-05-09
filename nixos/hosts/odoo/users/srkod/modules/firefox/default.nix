{ pkgs
, config
, system
, ...
}:
let
  addons        = import ./addons.nix { inherit pkgs system; };
  bookmarks     = import ./bookmarks.nix;
  containers    = import ./containers.nix;
  searchEngines = import ./search-engines.nix;
  settings      = import ./settings.nix;
in
{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    package = config.lib.nixGL.wrapOffload pkgs.firefox-bin;
    profiles = {
      odoo = {
        inherit containers;
        inherit settings;
        inherit bookmarks;
        isDefault = true;
        id = 0;
        containersForce = false;
        extensions = {
          packages = addons;
        };
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
          engines = searchEngines;
        };
      };

      personal = {
        inherit containers;
        inherit settings;
        inherit bookmarks;
        isDefault = false;
        id = 1;
        containersForce = false;
        extensions = {
          packages = addons;
        };
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
          engines = searchEngines;
        };
      };

    };
  };
}
