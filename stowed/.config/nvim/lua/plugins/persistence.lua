return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  module = "persistence",
  config = function()
    require("persistence").setup()
  end,
}
