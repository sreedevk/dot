return {
  'utilyre/barbecue.nvim',
  dependencies = { 'SmiteshP/nvim-navic' },
  config = function()
    require('barbecue').setup({
      create_autocmd = false,
      exclude_filetypes = { "neo-tree", "neo-tree-popup", "notify", "gitcommit", "toggleterm" }
    })

    require('helpers').create_augroups({
      barbecue = { {
        "WinScrolled", "*", "silent! lua require('barbecue.ui').update()"
      } }
    })
  end
}
