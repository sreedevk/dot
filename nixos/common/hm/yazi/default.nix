{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yazi
  ];

  home.file = {
    ".config/yazi/init.lua" = {
      enable = true;
      source = ./configs/init.lua;
    };

    ".config/yazi/keymap.toml" = {
      enable = true;
      source = ./configs/keymap.toml;
    };

    ".config/yazi/theme.toml" = {
      enable = true;
      source = ./configs/theme.toml;
    };

    ".config/yazi/yazi.toml" = {
      enable = true;
      source = ./configs/yazi.toml;
    };

    ".config/yazi/package.toml.source" = {
      enable = true;
      source = ./configs/package.toml;
      onChange = ''
        rm -rf ~/.config/yazi/package.toml && cat ~/.config/yazi/package.toml.source > ~/.config/yazi/package.toml
      '';
    };
  };
}
