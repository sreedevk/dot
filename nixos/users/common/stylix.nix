{ pkgs, config, nixpkgs-stable, opts, lib, system, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base0A";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    imageScalingMode = "fill"; # fill,fit,stretch,center,tile

    opacity = {
      terminal = 0.8;
    };

    fonts = {
      sizes = {
        applications = 14;
        desktop = 14;
        popups = 14;
        terminal = 14;
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.iosevka-term;
        name = "Iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      bat.enable = true;
      btop.enable = true;
      feh.enable = true;
      fzf.enable = true;
      gtk.enable = true;
      hyprland.enable = false;
      i3.enable = false;
      nushell.enable = true;
      rofi.enable = false;
      sxiv.enable = true;
      tmux.enable = true;
      xresources.enable = true;
      zellij.enable = true;
    };
  };
}
