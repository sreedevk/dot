{ config, ... }:
{
  scrollback_lines = 10000;
  enable_audio_bell = false;
  resize_draw_strategy = "scale";
  update_check_interval = 0;
  opacity = 0.95;
  bell_on_tab = " ";
  copy_on_select = true;
  cursor_blink_interval = 0;
  cursor_trail = 0;
  cursor_trail_start_threshold = 100;
  disable_ligatures = "cursor";
  font_family = "Iosevka NF";
  font_size = 14.0;
  scrollback_pager = "${config.programs.neovim.package}/bin/nvim -c \"lua require('core.utils'):colorize()\"";
  pointer_shape_when_dragging = "hand";
  touch_scroll_multiplier = 2.0;
  tab_bar_edge = "top";
  tab_bar_align = "left";
  active_tab_font_style = "italic";
}
