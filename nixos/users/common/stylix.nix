{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    image = config.lib.stylix.pixel "base0A";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    imageScalingMode = "fill";

    opacity = {
      terminal = 0.8;
      popups = 0.8;
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
        name = "IosevkaTerm NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      gtk.enable = true;
      nushell.enable = true;
      sxiv.enable = true;
      xresources.enable = true;
    };
  };
}
