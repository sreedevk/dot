return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre",
  keys = { '<leader>sl', '<leader>so', '<leader>sd' },
  module = "persistence",
  config = function()
    require("persistence").setup()

    local map = vim.keymap.set
    map('n', '<leader>sl', [[<cmd>lua require("persistence").load({last=true})<cr>]], { noremap = true })
    map('n', '<leader>so', [[<cmd>lua require("persistence").load()<cr>]], { noremap = true })
    map('n', '<leader>sd', [[<cmd>lua require("persistence").stop()<cr>]], { noremap = true })
  end,
}
