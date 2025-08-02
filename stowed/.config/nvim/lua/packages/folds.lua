return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = true,
    ft = { "markdown" },
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {}
  },
  {
    "jghauser/fold-cycle.nvim",
    lazy = true,
    -- TODO: Disable <C-i> remap by this plugin
    enabled = false,
    ft = { "markdown" },
    keys = {
      { '<tab>',   function() require('fold-cycle').open() end,  desc = "Open Folds",  silent = true },
      { '<s-tab>', function() require('fold-cycle').close() end, desc = "Close Folds", silent = true }
    },
    opts = {
      open_if_max_closed = true,
      close_if_max_opened = true,
      softwrap_movement_fix = false
    },
  }
}
