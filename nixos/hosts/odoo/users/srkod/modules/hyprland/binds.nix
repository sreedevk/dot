{ config, pkgs, ... }:
''
  hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("${config.programs.kitty.package}/bin/kitty"))
  hl.bind("SUPER + CTRL + Return", hl.dsp.exec_cmd("${config.programs.alacritty.package}/bin/alacritty"))
  hl.bind("SUPER + Return", hl.dsp.exec_cmd("${config.programs.kitty.package}/bin/kitty tmux new -A -s system"))
  hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl s 10%-"))
  hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl s 10%+"))
  hl.bind("SUPER + XF86AudioLowerVolume", hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl s 10%-"))
  hl.bind("SUPER + XF86AudioRaiseVolume", hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl s 10%+"))
''
