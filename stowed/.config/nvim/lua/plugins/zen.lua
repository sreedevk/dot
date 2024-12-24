return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    keys = {
      {
        '<Leader>tz',
        function()
          require("zen-mode").toggle({
            window = {
              width = .85
            }
          })
        end,
        desc = "Toggle Zen Mode"
      },
    },
    opts = {
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        kitty = {
          enabled = false,
          font = "+4",
        },
        alacritty = {
          enabled = true,
          font = "18"
        },
        neovide = {
          enabled = true,
          scale = 1.2,
          disable_animations = {
            neovide_animation_length = 0,
            neovide_cursor_animate_command_line = false,
            neovide_scroll_animation_length = 0,
            neovide_position_animation_length = 0,
            neovide_cursor_animation_length = 0,
            neovide_cursor_vfx_mode = "",
          }
        },
      },
      window = {
        backdrop = 1,
        height = 0.9,
        width = 0.8,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          list = false,
          cursorline = false,
        },
      },
    },
  },

  {
    'folke/twilight.nvim',
    lazy = true,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    dependencies = { 'folke/zen-mode.nvim' },
    opts = { context = -1, treesitter = true }
  },
}
