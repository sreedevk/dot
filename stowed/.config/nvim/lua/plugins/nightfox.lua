return {
  'EdenEast/nightfox.nvim',
  config = function()
    require('nightfox').setup({
      options = {
        transparent = false,
      }
    })

    vim.cmd('colorscheme carbonfox')
  end
}
