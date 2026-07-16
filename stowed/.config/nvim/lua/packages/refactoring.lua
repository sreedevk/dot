return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "lewis6991/async.nvim",
  },
  cmd = { "Refactor" },
  lazy = true,
  opts = {},
  keys = {
    {
      "<Leader>re",
      function()
        require("refactoring").select_refactor()
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Select refactor"
    },
  },
}
