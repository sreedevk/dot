if vim.g.neovide then
  vim.g.neovide_transparency             = 0.75
  vim.g.neovide_floating_blur_amount_x   = 2.0
  vim.g.neovide_floating_blur_amount_y   = 2.0
  vim.g.neovide_profiler                 = false
  vim.g.neovide_cursor_antialiasing      = true
  vim.o.guifont                          = "Iosevka NF:h14"
  vim.g.neovide_fullscreen               = false
  vim.g.neovide_padding_top              = 0
  vim.g.neovide_padding_bottom           = 0
  vim.g.neovide_padding_right            = 0
  vim.g.neovide_padding_left             = 0
  vim.g.neovide_hide_mouse_when_typing   = true
  vim.g.neovide_scale_factor             = 1.0
  vim.g.neovide_scroll_animation_length  = 0.3
  vim.g.neovide_refresh_rate             = 90

  local map                            = require('helpers').map

  map('n', '<C-=>', '<cmd>lua vim.g.neovide_scale_factor=vim.g.neovide_scale_factor+0.1<CR>')
  map('n', '<C-->', '<cmd>lua vim.g.neovide_scale_factor=vim.g.neovide_scale_factor-0.1<CR>')
  map('n', '<C-0>', '<cmd>lua vim.g.neovide_scale_factor=1.0<CR>')
end
