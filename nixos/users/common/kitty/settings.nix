{ config, lib, ... }:
# BUG: running kitty in xwayland mode automatically 
#      starts kitty in floating mode in hyprland.
#      -- linux_display_server = "x11";
{
  active_tab_font_style = "italic";
  background_opacity = lib.mkForce 0.8;
  bell_on_tab = " ";
  close_on_child_death = true;
  copy_on_select = true;
  cursor_blink_interval = 0;
  cursor_trail = 0;
  cursor_trail_start_threshold = 100;
  disable_ligatures = "cursor";
  enable_audio_bell = false;
  font_family = "Iosevka Nerd Font";
  font_size = 14.0;
  input_delay = 3;
  pointer_shape_when_dragging = "hand";
  scrollback_lines = 10000;
  scrollback_pager = "${config.programs.neovim.package}/bin/nvim -c \"lua require('core.utils'):colorize()\"";
  selection_foreground = "none";
  shell_integration = "disabled";
  tab_bar_align = "left";
  tab_bar_edge = "top";
  touch_scroll_multiplier = 2.0;
  update_check_interval = 0;
}
