return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "Refactor" },
  lazy = true,
  opts = {},
  keys = {
    {
      "<Leader>re",
      function()
        return require('refactoring').refactor('Extract Function')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Extract Function",
    },
    {
      "<Leader>rf",
      function()
        return require('refactoring').refactor('Extract Function To File')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Extract To File",
    },
    {
      "<Leader>rv",
      function()
        return require('refactoring').refactor('Extract Variable')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Variable",
    },
    {
      "<leader>rI",
      function()
        return require('refactoring').refactor('Inline Function')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Inline Function",
    },
    {
      "<leader>ri",
      function()
        return require('refactoring').refactor('Inline Variable')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Inline Variable"
    },
    {
      "<leader>rbb",
      function()
        return require('refactoring').refactor('Extract Block')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Extract Block"
    },
    {
      "<leader>rbf",
      function()
        return require('refactoring').refactor('Extract Block To File')
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Refactor Extract Block to File"
    },
  },
}
