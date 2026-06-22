{ pkgs, ... }:
let
  addons = import ./addons.nix { inherit pkgs; };
  bookmarks = import ./bookmarks.nix;
  containers = import ../common/containers.nix;
  searchEngines = import ../common/search-engines.nix;
  settings = import ../common/settings.nix;
in
{
  programs.firefox = {
    profiles = {
      main = {
        name = "main";
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
