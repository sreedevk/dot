return {
  'protex/better-digraphs.nvim',
  lazy = true,
  branch = 'unstable',
  keys = {
    {
      "<C-v><C-u>",
      function()
        require('betterdigraphs').digraphs("i")
      end,
      mode = { "i" },
      noremap = true,
    }
  },
  dependencies = { 'nvim-telescope/telescope.nvim' },
  init = function()
    vim.g.BetterDigraphsAdditions = {
      { digraph = "TH", symbol = "ø", name = "theta" },
    }
  end
}
