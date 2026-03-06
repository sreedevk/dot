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
    package = config.lib.nixGL.wrapOffload pkgs.firefox-bin;
    profiles = {

      main = {
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

    };
  };
}
