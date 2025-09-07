{ pkgs
, config
, system
, ...
}:
let
  extensions = import ./extensions.nix { inherit pkgs system; };
  settings = import ./settings.nix;
  searchEngines = import ./search-engines.nix;
  bookmarks = import ./bookmarks.nix;
  containers = import ./containers.nix;
in
{
  programs.firefox = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.firefox-bin;
    profiles = {

      main = {
        isDefault = true;
        id = 0;
        containersForce = false;
        inherit containers;
        extensions = {
          packages = extensions;
        };
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
          engines = searchEngines;
        };
        inherit settings;
        inherit bookmarks;
      };

    };
  };
}
