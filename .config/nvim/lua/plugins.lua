vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'dense-analysis/ale',
    ft = {
      'sh',
      'zsh',
      'bash',
      'c',
      'cpp',
      'cmake',
      'html',
      'markdown',
      'racket',
      'vim',
      'tex',
      'ruby',
      'rust'
    },
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'phaazon/hop.nvim', as = 'hop', config = function()
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } 
  end }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'mattn/emmet-vim' }
  use { 'scrooloose/nerdTree' }
  use { 'sjl/gundo.vim' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rails' }
  use { 'hoob3rt/lualine.nvim' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-surround' }
  use { 'bollu/vim-apl' }
  use { 'ayu-theme/ayu-vim' }
  use { 'dracula/vim', as = 'dracula' }
  use { 'cseelus/vim-colors-lucid' }
  use { 'neovim/nvim-lspconfig' }
end)
