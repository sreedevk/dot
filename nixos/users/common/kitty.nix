{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      genericName = "Terminal";
      exec = "kitty";
      icon = "Kitty";
      terminal = false;
      categories = [ "System" "TerminalEmulator" ];
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    font = {
      name = "Iosevka NF";
      size = lib.mkForce 28;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      background_opacity = "0.8";
    };
    package = nixglmod.nixGLWrapped pkgs.kitty "kitty";
  };
}
