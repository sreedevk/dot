{ pkgs, lib, system, ... }: {
  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/images2/Free-download-Computer-Art-Photo.jpg";
      sha256 = "sha256-tJ8k+rdmHLwrxgplmmawDcc6ROQkN8HQhCJCpoM1CP4=";
    };

    imageScalingMode = "fill"; # fill,fit,stretch,center,tile
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    fonts = {
      sizes = {
        applications = 14;
        desktop = 14;
        popups = 18;
        terminal = 22;
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
      i3.enable = false;
      nushell.enable = true;
      rofi.enable = false;
      tmux.enable = true;
      xresources.enable = true;
      sxiv.enable = true;
      zellij.enable = true;
    };
  };
}
