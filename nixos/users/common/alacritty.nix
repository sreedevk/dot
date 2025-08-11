{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.alacritty;
    settings = {
      general = {
        working_directory = "None";
        live_config_reload = true;
        ipc_socket = true;
      };
      colors = {
        draw_bold_text_with_bright_colors = true;
      };

      font = {
        normal = { family = "IosevkaTerm Nerd Font"; style = "Regular"; };
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
          { key = "O"; mods = "None"; action = "Open"; mode = "Vi"; }
          { key = "Escape"; mods = "Control"; action = "ToggleViMode"; }
          { key = "Escape"; mods = "None"; action = "ToggleViMode"; mode = "Vi"; }
          { key = "Return"; mods = "None"; action = "ToggleViMode"; mode = "Vi"; }
          { key = "I"; mods = "None"; action = "ToggleViMode"; mode = "Vi"; }
          { key = "Tab"; mods = "None"; action = "SearchFocusNext"; mode = "Search"; }
          { key = "Tab"; mods = "Shift"; action = "SearchFocusPrevious"; mode = "Search"; }
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
          foreground = "#e6edf3";
          background = "#010409";
          dim_foreground = "#908caa";
          bright_foreground = "#e0def4";
        };
        cursor = {
          text = "#010409";
          cursor = "#e6edf3";
        };
        vi_mode_cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };
        search = {
          matches = {
            foreground = "#908caa";
            background = "#26233a";
          };
          focused_match = {
            foreground = "#191724";
            background = "#ebbcba";
          };
        };
        hints = {
          start = {
            foreground = "#908caa";
            background = "#1f1d2e";
          };
          end = {
            foreground = "#6e6a86";
            background = "#1f1d2e";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        footer_bar = {
          foreground = "#e0def4";
          background = "#1f1d2e";
        };
        selection = {
          text = "#e6edf3";
          background = "#264f78";
        };
        normal = {
          black = "#484f58";
          red = "#ff7b72";
          green = "#3fb950";
          yellow = "#d29922";
          blue = "#58a6ff";
          magenta = "#bc8cff";
          cyan = "#39c5cf";
          white = "#b1bac4";
        };
        bright = {
          black = "#6e7681";
          red = "#ffa198";
          green = "#56d364";
          yellow = "#e3b341";
          blue = "#79c0ff";
          magenta = "#d2a8ff";
          cyan = "#56d4dd";
          white = "#ffffff";
        };
        dim = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
      };

      window = {
        opacity = 0.9;
        blur = true;
        decorations = "None";
        padding = { x = 5; y = 5; };
      };
    };
  };
}
