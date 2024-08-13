{ pkgs, lib, stylix, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{

  stylix = {
    targets.kitty = {
      enable = true;
      variant256Colors = true;
    };
    opacity.terminal = 0.8;
  };

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
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
    };
    keybindings = {
      "ctrl+=" = "change_font_size all +2.0";
      "ctrl+-" = "change_font_size all -2.0";
    };
    package = nixglmod.nixGLWrapped pkgs.kitty "kitty";
  };
}
