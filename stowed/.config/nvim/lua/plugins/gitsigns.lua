return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = "BufReadPost",
  config = function()
    require('gitsigns').setup()
  end
}
