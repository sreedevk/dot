if vim.g.neovide then
  vim.g.neovide_transparency            = 0.8
  vim.g.neovide_floating_blur_amount_x  = 0.0
  vim.g.neovide_floating_blur_amount_y  = 0.0
  vim.g.neovide_window_blurred          = true
  vim.g.neovide_profiler                = false
  vim.g.neovide_cursor_antialiasing     = true
  vim.o.guifont                         = "IosevkaTerm NF:h14"
  vim.g.neovide_fullscreen              = false
  vim.g.neovide_padding_top             = 0
  vim.g.neovide_padding_bottom          = 0
  vim.g.neovide_padding_right           = 0
  vim.g.neovide_padding_left            = 0
  vim.g.neovide_hide_mouse_when_typing  = true
  vim.g.neovide_scale_factor            = 1.0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate            = 90
  local map                             = vim.keymap.set

  map('n', '<C-=>', '<cmd>lua vim.g.neovide_scale_factor=vim.g.neovide_scale_factor+0.1<CR>', { noremap = true })
  map('n', '<C-->', '<cmd>lua vim.g.neovide_scale_factor=vim.g.neovide_scale_factor-0.1<CR>', { noremap = true })
  map('n', '<C-0>', '<cmd>lua vim.g.neovide_scale_factor=1.0<CR>', { noremap = true })
  map('n', '<Leader>rq', function()
    os.execute("neovide --fork &")
    vim.defer_fn(function()
      local handle, pid = io.popen("pgrep neovide"), nil
      if handle then
        pid = handle:read("*a")
        handle:close()

        if pid ~= nil and pid ~= "" then
          os.execute("kill " .. pid)
        end
      end
    end, 500)
  end, { noremap = true })
end
