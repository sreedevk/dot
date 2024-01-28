return {
  'protex/better-digraphs.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim' 
  },
  config = function ()
    vim.g.BetterDigraphsAdditions = {
      {
        digraph = "TH",
        symbol = "ø",
        name = "theta"
      },
    }

    vim.keymap.set("i", "<C-v><C-u>", [[<cmd>lua require('better-digraphs').digraphs("insert")<cr>]])
  end
}
