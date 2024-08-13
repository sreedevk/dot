{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{

  stylix.targets.alacritty.enable = true;

  programs.alacritty = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.alacritty "alacritty";
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = true;
      };

      cursor = {
        unfocused_hollow = false;
      };

      env = {
        TERM = "xterm-256color";
      };

      keyboard = {
        bindings = [
          { action = "ScrollPageUp"; key = "U"; mode = "~Alt"; mods = "Alt"; }
          { action = "ScrollPageDown"; key = "D"; mode = "~Alt"; mods = "Alt"; }
          { action = "ToggleViMode"; key = "Escape"; mods = "Control"; }
          { action = "ToggleViMode"; key = "I"; mode = "Vi"; mods = "None"; }
          { action = "ToggleViMode"; key = "Return"; mode = "Vi"; mods = "None"; }
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

      shell = {
        args = [ "--login" ];
        program = "/usr/bin/zsh";
      };

      window = {
        decorations = "full";
        padding = { x = 5; y = 5; };
      };
    };
  };
}
