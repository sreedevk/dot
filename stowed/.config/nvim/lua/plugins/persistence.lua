return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  keys = { '<leader>sp', '<leader>so', '<leader>sd' },
  module = "persistence",
  config = function()
    require("persistence").setup()

    local map = vim.api.nvim_set_keymap
    map('n', '<leader>sp', [[<cmd>lua require("persistence").load({last=true})<cr>]], { noremap = true })
    map('n', '<leader>so', [[<cmd>lua require("persistence").load()<cr>]], { noremap = true })
    map('n', '<leader>sd', [[<cmd>lua require("persistence").stop()<cr>]], { noremap = true })
  end,
}
