{ config, ... }:
{

  home.file = {
    ".config/zellij/themes/dracula.kdl" = {
      enable = true;
      text = ''
        themes {
           dracula {
                fg 248 248 242
                bg 40 42 54
                black 0 0 0
                red 255 85 85
                green 80 250 123
                yellow 241 250 140
                blue 98 114 164
                magenta 255 121 198
                cyan 139 233 253
                white 255 255 255
                orange 255 184 108
            }
        }
      '';
    };

    ".config/zellij/layouts/.keep" = {
      enable = true;
      text = "";
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      on_force_close = "quit";
      simplified_ui = true;
      mouse_mode = false;
      scroll_buffer_size = 50000;
      copy_command = "wl-copy";
      copy_on_select = false;
      scrollback_editor = "${config.programs.neovim.package}/bin/nvim -c \"lua require('core.utils'):colorize()\"";
      mirror_session = false;
      theme = "dracula";
      layout_dir = "${builtins.getEnv "HOME"}/.config/zellij/layouts/";
      theme_dir = "${builtins.getEnv "HOME"}/.config/zellij/themes/";
      session_serialization = true;
      pane_viewport_serialization = false;
      disable_session_metadata = false;
      env = { };
      auto_layout = true;
      styled_underlines = false;
      ui = {
        pane_frames = {
          rounded_corners = false;
          hide_session_name = false;
        };
      };
    };
  };
}
