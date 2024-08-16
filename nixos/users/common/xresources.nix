{ pkgs, lib, ... }:
{
  xresources = {
    properties = {
      "Xft.dpi" = 128;
      "Xft.autohint" = 0;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
      "*.renderFont" = true;
      "*foreground" = lib.mkForce "#bdcfe3";
      "*background" = lib.mkForce "#141c21L";
      "*color0" = lib.mkForce "#263640";
      "*color8" = lib.mkForce "#4a697d";
      "*color1" = lib.mkForce "#d12f2c";
      "*color9" = lib.mkForce "#fa3935";
      "*color2" = lib.mkForce "#819400";
      "*color10" = lib.mkForce "#a4bd00";
      "*color3" = lib.mkForce "#b08500";
      "*color11" = lib.mkForce "#d9a400";
      "*color4" = lib.mkForce "#2587cc";
      "*color12" = lib.mkForce "#2ca2f5";
      "*color5" = lib.mkForce "#696ebf";
      "*color6" = lib.mkForce "#289c93";
      "*color14" = lib.mkForce "#33c5ba";
      "*color13" = lib.mkForce "#8086e8";
      "*color7" = lib.mkForce "#bfbaac";
      "*color15" = lib.mkForce "#fdf6e3";
    };
  };
}
