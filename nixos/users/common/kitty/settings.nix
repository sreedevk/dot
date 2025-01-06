{ config, ... }:
{
  active_tab_font_style = "italic";
  background_opacity = 0.8;
  bell_on_tab = " ";
  copy_on_select = true;
  cursor_blink_interval = 0;
  cursor_trail = 0;
  cursor_trail_start_threshold = 100;
  disable_ligatures = "cursor";
  enable_audio_bell = false;
  font_family = "Iosevka NF";
  font_size = 14.0;
  pointer_shape_when_dragging = "hand";
  resize_draw_strategy = "scale";
  scrollback_lines = 10000;
  scrollback_pager = "${config.programs.neovim.package}/bin/nvim -c \"lua require('core.utils'):colorize()\"";
  tab_bar_align = "left";
  tab_bar_edge = "top";
  touch_scroll_multiplier = 2.0;
  update_check_interval = 0;
}
