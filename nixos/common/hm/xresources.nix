{ lib, ... }:
{
  home.file = {
    ".Xdefaults" = {
      enable = true;
      text = ''
        ! Cursor {{{1
        Xcursor.size: 18

        ! Xft {{{1
        Xft.dpi: 128
        Xft.autohint: 0
        Xft.lcdfilter:  lcddefault
        Xft.hintstyle:  hintfull
        Xft.hinting: 1
        Xft.antialias: 1
        Xft.rgba: rgb

        *.font: DejaVu Sans-14

        ! Colors {{{1
        ! special
        *foreground: #bdcfe3
        *background: #141c21

        ! black
        *color0: #263640
        *color8: #4a697d

        ! red
        *color1: #d12f2c
        *color9: #fa3935

        ! green
        *color2:  #819400
        *color10: #a4bd00

        ! yellow
        *color3:  #b08500
        *color11: #d9a400

        ! blue
        *color4:  #2587cc
        *color12: #2ca2f5

        ! magenta
        *color5:  #696ebf
        *color13: #8086e8

        ! cyan
        *color6:  #289c93
        *color14: #33c5ba

        ! white
        *color7:  #bfbaac
        *color15: #fdf6e3

        ! vim:foldmethod=marker
      '';
    };
  };

  xresources = {
    properties = {
      "*.renderFont" = true;
      "*background" = lib.mkForce "#141c21";
      "*color0" = lib.mkForce "#263640";
      "*color1" = lib.mkForce "#d12f2c";
      "*color10" = lib.mkForce "#a4bd00";
      "*color11" = lib.mkForce "#d9a400";
      "*color12" = lib.mkForce "#2ca2f5";
      "*color13" = lib.mkForce "#8086e8";
      "*color14" = lib.mkForce "#33c5ba";
      "*color15" = lib.mkForce "#fdf6e3";
      "*color2" = lib.mkForce "#819400";
      "*color3" = lib.mkForce "#b08500";
      "*color4" = lib.mkForce "#2587cc";
      "*color5" = lib.mkForce "#696ebf";
      "*color6" = lib.mkForce "#289c93";
      "*color7" = lib.mkForce "#bfbaac";
      "*color8" = lib.mkForce "#4a697d";
      "*color9" = lib.mkForce "#fa3935";
      "*foreground" = lib.mkForce "#bdcfe3";
      "Sxiv.background" = lib.mkForce "#908caa";
      "Sxiv.font" = "DejaVu Sans-14";
      "Sxiv.foreground" = lib.mkForce "#1f1d2e";
      "Xft.antialias" = 1;
      "Xft.autohint" = 0;
      "Xft.dpi" = 128;
      "Xft.hinting" = 1;
      "Xft.hintstyle" = "hintfull";
      "Xft.lcdfilter" = "lcddefault";
      "Xft.rgba" = "rgb";
    };
  };
}
