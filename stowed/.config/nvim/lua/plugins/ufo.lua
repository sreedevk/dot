return {
  {
    'kevinhwang91/nvim-ufo',
    lazy = true,
    depedencies = { 'kevinhwang91/promise-async' },
    keys = {
      { 'zR', function() require("ufo").openAllFolds() end,  noremap = true, desc = "Open All Folds" },
      { 'zM', function() require("ufo").closeAllFolds() end, noremap = true, desc = "Close All Folds" }
    },
    opts = {
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
        json = { 'array' },
        c = { 'comment', 'region' }
      },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']'
        }
      },
    },
    config = true,
  }
}
