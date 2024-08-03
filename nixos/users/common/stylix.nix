{ pkgs, lib, system, ... }: {
  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/images2/Free-download-Computer-Art-Photo.jpg";
      sha256 = "sha256-tJ8k+rdmHLwrxgplmmawDcc6ROQkN8HQhCJCpoM1CP4=";
    };

    imageScalingMode = "fill"; # fill,fit,stretch,center,tile

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";

    fonts = {
      sizes = {
        applications = 12;
        desktop = 12;
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
      alacritty.enable = true;
      bat.enable = true;
      btop.enable = true;
      dunst.enable = true;
      feh.enable = true;
      firefox.enable = true;
      fzf.enable = true;
      gtk.enable = true;
      i3.enable = false;
      nushell.enable = true;
      rofi.enable = false;
      sxiv.enable = false;
      tmux.enable = true;
      xresources.enable = true;
      zathura.enable = false;
      zellij.enable = true;
    };
  };
}
