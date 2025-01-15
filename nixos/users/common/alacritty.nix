{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
  theme = (import ./themes.nix).zitchdog-grape;
in
{
  programs.alacritty = {
    enable = true;
    # ISSUE: -----------------------------------------------------------------------------
    # pkgs.alacritty contains 0.14, will revert to pkgs.alacritty after 0.15 released
    # check: https://github.com/NixOS/nixpkgs/pull/373582/files
    # ------------------------------------------------------------------------------------
    package = pkgs.writeShellScriptBin "alacritty" ''
      /usr/bin/alacritty $@
    '';
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = true;
      };

      font = {
        normal = { family = "Iosevka NF"; style = "Regular"; };
        size = 14.0;
      };

      cursor = {
        unfocused_hollow = false;
      };

      env = {
        TERM = "xterm-256color";
      };

      keyboard = {
        bindings = [
          { key = "U"; mods = "Alt"; action = "ScrollPageUp"; mode = "~Alt"; }
          { key = "D"; mods = "Alt"; action = "ScrollPageDown"; mode = "~Alt"; }
          { key = "Escape"; mods = "Control"; action = "ToggleViMode"; }
          { key = "I"; mods = "None"; action = "ToggleViMode"; mode = "Vi"; }
          { key = "Return"; mods = "None"; action = "ToggleViMode"; mode = "Vi"; }
        ];
      };

      mouse = {
        bindings = [
          { action = "PasteSelection"; mouse = "Middle"; }
        ];
      };

      scrolling = {
        multiplier = 5;
        history = 20000;
      };

      selection = {
        save_to_clipboard = true;
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      };

      terminal = {
        shell = {
          args = [ "--login" ];
          program = "${pkgs.zsh}/bin/zsh";
        };
      };

      colors = {
        primary = {
          background = theme.background;
          foreground = theme.foreground;
        };
        cursor = {
          cursor = theme.cursor;
        };
        selection = {
          text = "#FFFFFF";
          background = "#C76E00";
        };
        normal = {
          black = theme.color0;
          red = theme.color1;
          green = theme.color2;
          yellow = theme.color3;
          blue = theme.color4;
          magenta = theme.color5;
          cyan = theme.color6;
          white = theme.color7;
        };
        bright = {
          black = theme.color8;
          red = theme.color9;
          green = theme.color10;
          yellow = theme.color11;
          blue = theme.color12;
          magenta = theme.color13;
          cyan = theme.color14;
          white = theme.color15;
        };
      };

      window = {
        opacity = 0.8;
        blur = true;
        decorations = "full";
        padding = { x = 5; y = 5; };
      };
    };
  };
}
