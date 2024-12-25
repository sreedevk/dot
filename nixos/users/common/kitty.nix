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
      opacity = 0.95;
    };

    keybindings = {
      "ctrl+=" = "change_font_size all +2.0";
      "ctrl+-" = "change_font_size all -2.0";
    };

    extraConfig = ''
      # Config
      scrollback_pager         ${pkgs.neovim}/bin/nvim -c "lua require('utils'):colorize()"
      copy_on_select           yes
      scrollback_lines         10000
      font_family              Iosevka NF
      touch_scroll_multiplier  2.0
      copy_on_select           yes

      # Theme
      active_tab_background    #26233a
      active_tab_foreground    #e0def4
      background               #191724
      color0                   #26233a
      color1                   #eb6f92
      color2                   #31748f
      color3                   #f6c177
      color4                   #9ccfd8
      color5                   #c4a7e7
      color6                   #ebbcba
      color7                   #e0def4
      color8                   #6e6a86
      color9                   #eb6f92
      color10                  #31748f
      color11                  #f6c177
      color12                  #9ccfd8
      color13                  #c4a7e7
      color14                  #ebbcba
      color15                  #e0def4
      cursor                   #524f67
      cursor_text_color        #e0def4
      foreground               #e0def4
      inactive_tab_background  #191724
      inactive_tab_foreground  #6e6a86
      selection_background     #403d52
      selection_foreground     #e0def4
      url_color                #c4a7e7
    '';
  };
}
