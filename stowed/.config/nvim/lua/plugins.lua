vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- plugin manager
  use 'mattn/emmet-vim'        -- html emmets
  use 'scrooloose/nerdTree'    -- project filetree
  use 'sjl/gundo.vim'          -- undo tree
  use 'tpope/vim-surround'     -- ysiw
  use 'hoob3rt/lualine.nvim'   -- statusline
  use 'tpope/vim-fugitive'     -- git
  use 'psliwka/vim-smoothie'   -- smooth scrolling
  use 'tpope/vim-rails'        -- rails support

  -- colorschemes
  use 'ayu-theme/ayu-vim'
  use 'ghifarit53/tokyonight-vim'

  -- Language Server + Intellisense
  -- use 'neovim/nvim-lspconfig'
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'sheerun/vim-polyglot'
  use { 'neoclide/coc.nvim', branch = 'release' }

  -- Fzf
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-project.nvim' } }
  use {'pwntester/octo.nvim', config=function()
    require"octo".setup()
  end}

  -- EasyMotion
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  -- VimDev
  use 'rafcamlet/nvim-luapad'

end)
