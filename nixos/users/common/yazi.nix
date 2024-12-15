{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yazi
  ];

  home.file = {
    ".config/yazi/yazi.toml" = {
      enable = true;
      text = ''
        [manager]
        sort_by = "alphabetical"
        sort_sensitive = true
        sort_reverse = false
        sort_dir_first = true
        sort_translit = false
        linemode = "size"
        show_hidden = true
        show_symlink = true
        scrolloff = 0

        [preview]
        wrap = "yes"
        tab_size = 4

        [opener]
        play = [{ run = 'mpv "$@"', orphan = true, for = "unix"}]
        edit = [{ run = '$EDITOR "$@"', block = true, for = "unix" }]
        open = [{ run = 'xdg-open "$@"', desc = "Open" }]
      '';
    };
    # ".config/yazi/keymap.toml" = {};
    # ".config/yazi/theme.toml" = {};
  };
}
