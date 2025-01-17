local wezterm = require 'wezterm'
local colors  = require 'colors'
local keys    = require 'keys'

return {
  color_schemes                = colors,
  font                         = wezterm.font { family = 'Iosevka NF', weight = 'Medium' },
  font_size                    = 16,
  window_background_opacity    = 0.8,
  max_fps                      = 120,
  keys                         = keys,
  front_end                    = 'WebGpu',
  webgpu_power_preference      = 'HighPerformance',
  color_scheme                 = 'ZitchdogGrape',
  animation_fps                = 120,
  enable_scroll_bar            = true,
  cursor_blink_ease_in         = 'EaseOut',
  cursor_blink_ease_out        = 'EaseOut',
  default_cursor_style         = 'BlinkingBlock',
  cursor_blink_rate            = 650,
  hide_tab_bar_if_only_one_tab = true,
  window_padding               = {
    left   = 4,
    right  = 4,
    top    = 4,
    bottom = 4
  }
}
