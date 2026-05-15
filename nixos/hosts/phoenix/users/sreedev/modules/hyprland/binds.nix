{ config, ... }:
''
  hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("${config.programs.kitty.package}/bin/kitty"))
  hl.bind("SUPER + CTRL + Return", hl.dsp.exec_cmd("${config.programs.alacritty.package}/bin/alacritty"))
  hl.bind("SUPER + Return", hl.dsp.exec_cmd("${config.programs.kitty.package}/bin/kitty tmux new -A -s system"))
''
