return {
  'protex/better-digraphs.nvim',
  lazy = true,
  keys = {
    {
      "<C-v><C-u>",
      function()
        require('better-digraphs').digraphs("insert")
      end,
      mode = { "i" },
    }
  },
  dependencies = { 'nvim-telescope/telescope.nvim' },
  init = function()
    vim.g.BetterDigraphsAdditions = {
      { digraph = "TH", symbol = "ø", name = "theta" },
    }
  end
}
