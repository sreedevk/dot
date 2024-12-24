{ pkgs, lib, stylix, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{

  stylix.targets.kitty.enable = true;
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
    package = nixglmod.nixGLWrapped pkgs.kitty "kitty";
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      opacity = 0.8;
    };
    keybindings = {
      "ctrl+=" = "change_font_size all +2.0";
      "ctrl+-" = "change_font_size all -2.0";
    };
    extraConfig = ''
      copy_on_select yes
      scrollback_pager ${pkgs.neovim}/bin/nvim -c "lua require('utils'):colorize()"
    '';
  };
}
