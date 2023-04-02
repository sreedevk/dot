return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  event = "BufWinEnter",
  config = function()
    require("alpha").setup(require('alpha.themes.startify').config)
  end
}
