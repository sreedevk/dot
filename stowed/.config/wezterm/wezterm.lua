local wezterm = require 'wezterm'
local colors  = require 'colors'
local keys    = require 'keys'

return {
  color_schemes                = colors,
  font                         = wezterm.font { family = 'Iosevka NF', weight = 'Medium' },
  font_size                    = 14,
  window_background_opacity    = 0.9,
  max_fps                      = 120,
  keys                         = keys,
  front_end                    = 'WebGpu',
  webgpu_power_preference      = 'HighPerformance',
  color_scheme                 = 'Banana Blueberry',
  animation_fps                = 120,
  enable_scroll_bar            = false,
  cursor_blink_ease_in         = 'Linear',
  cursor_blink_ease_out        = 'Linear',
  default_cursor_style         = 'SteadyBlock',
  cursor_blink_rate            = 800,
  automatically_reload_config  = false,
  check_for_updates            = false,
  hide_tab_bar_if_only_one_tab = true,
  window_padding               = {
    left   = 4,
    right  = 4,
    top    = 4,
    bottom = 4
  }
}
