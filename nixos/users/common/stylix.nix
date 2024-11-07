{ pkgs, opts, lib, system, ... }: {
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/images2/Free-download-Computer-Art-Photo.jpg";
      sha256 = "sha256-tJ8k+rdmHLwrxgplmmawDcc6ROQkN8HQhCJCpoM1CP4=";
    };

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
        package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
        name = "Iosevka NF";
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
