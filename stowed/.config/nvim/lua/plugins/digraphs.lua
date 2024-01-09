return {
  'protex/better-digraphs.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim' 
  },
  config = function ()
    vim.g.BetterDigraphsAdditions = {
      {
        digraph = "OK",
        symbol = "*",
        name = "NEW STAR"
      },
      {
        digraph = "zz",
        symbol = "Z",
        name = "CAPITAL Z"
      }
    }

    vim.keymap.set("i", "<C-v><C-u>", [[<cmd>lua require('better-digraphs').digraphs("insert")<cr>]])
  end
}
