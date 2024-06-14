{ pkgs, secrets, lib, inputs, system, ... }: {
  stylix = {
    enable = true;
    image = ../../../wallpapers/leaves.jpg;
    imageScalingMode = "fill"; # fill,fit,stretch,center,tile
    polarity = "dark";
    fonts = {

      sizes = {
        applications = 16;
        desktop = 16;
        popups = 22;
        terminal = 16;
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
      xresources.enable = true;
      zathura.enable = false;
      zellij.enable = true;
    };
  };
}
