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
    enabled = true,
    keys = {
      { '<M-TAB>',  function() require('fold-cycle').open() end,  desc = "Open Folds",  silent = true },
      { '<M-S-TAB>',  function() require('fold-cycle').close() end,  desc = "Open Folds",  silent = true },
    },
    opts = {
      open_if_max_closed = true,
      close_if_max_opened = true,
      softwrap_movement_fix = false
    },
  }
}
