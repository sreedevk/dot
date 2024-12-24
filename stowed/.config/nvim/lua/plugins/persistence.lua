return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre",
  keys = {
    { '<leader>sl', function() require("persistence").load({ last = true }) end, desc = "Load Last Session" },
    { '<leader>so', function() require("persistence").load() end,                desc = "Load Session For Current Directory" },
    { '<leader>sd', function() require("persistence").stop() end,                desc = "Don't Save Session on Exit" },
  },
  module = "persistence",
  config = true,
}
