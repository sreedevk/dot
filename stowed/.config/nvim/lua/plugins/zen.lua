return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    keys = {
      { '<Leader>tz', "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
    },
    opts = {
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
    cmd = { "ZenMode", "Twilight", "TwilightEnable", "TwilightDisable" },
    dependencies = { 'folke/zen-mode.nvim' },
    opts = { context = -1, treesitter = true }
  },
}
