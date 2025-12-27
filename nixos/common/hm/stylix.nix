{ pkgs, config, ... }:
{
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  stylix = {
    enable = true;
    autoEnable = false;
    enableReleaseChecks = false;
    polarity = "dark";
    image = config.lib.stylix.pixel "base0A";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
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
        name = "IosevkaTerm Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      gtk = {
        enable = true;
        flatpakSupport.enable = true;
      };
      qt = {
        enable = true;
        platform = "qtct";
      };
      xresources.enable = true;
      mpv.enable = true;
      zathura.enable = true;
      firefox = {
        enable = true;
        profileNames = [ "main" ];
        firefoxGnomeTheme.enable = false;
      };
    };
  };
}
