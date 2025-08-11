if vim.g.neovide then
  vim.g.neovide_opacity                 = 0.85
  vim.g.neovide_normal_opacity          = 0.95
  vim.g.neovide_floating_blur_amount_x  = 2.0
  vim.g.neovide_floating_blur_amount_y  = 2.0
  vim.g.neovide_window_blurred          = true
  vim.g.neovide_profiler                = false
  vim.g.neovide_cursor_antialiasing     = true
  vim.o.guifont                         = "Iosevka Nerd Font:h14"
  vim.g.neovide_fullscreen              = false
  vim.g.neovide_padding_top             = 0
  vim.g.neovide_padding_bottom          = 0
  vim.g.neovide_padding_right           = 0
  vim.g.neovide_padding_left            = 0
  vim.g.neovide_hide_mouse_when_typing  = true
  vim.g.neovide_scale_factor            = 1.3
  vim.g.neovide_scroll_animation_length = 0.0
  vim.g.neovide_refresh_rate            = 90

  local function kill_neovide()
    local handle, pid = io.popen("pgrep neovide"), nil
    if handle then
      pid = handle:read("*a")
      handle:close()

      if pid ~= nil and pid ~= "" then
        os.execute("kill " .. pid)
      end
    end
  end

  local function restart_neovide()
    os.execute("neovide --fork &")
    vim.defer_fn(kill_neovide, 500)
  end

  vim.keymap.set(
    'n',
    '<C-=>',
    function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
    end,
    {
      noremap = true,
      desc = "Zoom In (+)"
    }
  )

  vim.keymap.set(
    'n',
    '<C-->',
    function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
    end,
    {
      noremap = true,
      desc = "Zoom Out (-)"
    }
  )

  vim.keymap.set(
    'n',
    '<C-0>',
    function()
      vim.g.neovide_scale_factor = 1.0
    end,
    {
      noremap = true,
      desc = "Zoom Reset (=)"
    }
  )

  vim.keymap.set(
    'n',
    '<Leader>rq',
    restart_neovide,
    {
      noremap = true,
      desc = "Restart Neovide",
    }
  )
end
