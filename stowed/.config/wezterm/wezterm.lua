local wezterm       = require("wezterm")
local keybinds      = require("keybind")

local fonts           = { "Iosevka Nerd Font", "JetBrains Mono" }
local config          = wezterm.config_builder()

-- ColorScheme
config.color_scheme   = "Argonaut"

config.front_end      = "OpenGL"
config.font           = wezterm.font_with_fallback(fonts)
config.font_size      = 9
config.line_height    = 1.0
config.window_padding = { left = 5, right = 5, top = 10, bottom = 10 }

-- Tab Bar
config.enable_tab_bar               = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar    = false
config.tab_bar_at_bottom            = true

config.default_cursor_style         = "SteadyBlock"
config.warn_about_missing_glyphs    = false
config.enable_wayland               = false
config.disable_default_key_bindings = false
config.keys                         = keybinds
config.bold_brightens_ansi_colors   = true
config.automatically_reload_config  = true

config.inactive_pane_hsb            = { saturation = 1.0, brightness = 1.0 }
config.window_background_opacity    = 1.0
config.window_close_confirmation    = "NeverPrompt"
config.window_frame                 = {
  active_titlebar_bg = "#090909",
  font = wezterm.font_with_fallback(fonts)
}

return config
