{ pkgs, config, ... }:
let
  theme = (builtins.fromTOML (builtins.readFile ./colors/rose-pine.toml));
  settings = {
    general = {
      working_directory = "None";
      live_config_reload = true;
      ipc_socket = true;
    };

    font = {
      normal = {
        family = "IosevkaTerm Nerd Font";
        style = "Regular";
      };
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
        {
          key = "U";
          mods = "Alt";
          action = "ScrollPageUp";
          mode = "~Alt";
        }
        {
          key = "D";
          mods = "Alt";
          action = "ScrollPageDown";
          mode = "~Alt";
        }
        {
          key = "O";
          mods = "None";
          action = "Open";
          mode = "Vi";
        }
        {
          key = "Escape";
          mods = "Control";
          action = "ToggleViMode";
        }
        {
          key = "Escape";
          mods = "None";
          action = "ToggleViMode";
          mode = "Vi";
        }
        {
          key = "Return";
          mods = "None";
          action = "ToggleViMode";
          mode = "Vi";
        }
        {
          key = "I";
          mods = "None";
          action = "ToggleViMode";
          mode = "Vi";
        }
        {
          key = "Tab";
          mods = "None";
          action = "SearchFocusNext";
          mode = "Search";
        }
        {
          key = "Tab";
          mods = "Shift";
          action = "SearchFocusPrevious";
          mode = "Search";
        }
      ];
    };

    mouse = {
      bindings = [
        {
          action = "PasteSelection";
          mouse = "Middle";
        }
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

    window = {
      opacity = 0.9;
      blur = true;
      decorations = "None";
      padding = {
        x = 5;
        y = 5;
      };
    };

    terminal = {
      shell = {
        # args = [ "--login" ];
        program = "${pkgs.zsh}/bin/zsh";
      };
    };

    colors = {
      draw_bold_text_with_bright_colors = true;
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.alacritty;
    settings = pkgs.lib.attrsets.recursiveUpdate settings theme;
  };
}
