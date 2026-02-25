{ pkgs
, config
, system
, ...
}:
let
  bookmarks     = import ./bookmarks.nix;
  containers    = import ./containers.nix;
  extensions    = import ./extensions.nix { inherit pkgs system; };
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
          packages = extensions;
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
