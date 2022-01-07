vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- plugin manager
  use 'mattn/emmet-vim'        -- html emmets
  use 'scrooloose/nerdTree'    -- project filetree
  use 'sjl/gundo.vim'          -- undo tree
  use 'hoob3rt/lualine.nvim'   -- statusline
  use 'tpope/vim-fugitive'     -- git
  use 'tpope/vim-rails'        -- rails support
  use 'tpope/vim-surround'     -- ysiw
  use 'folke/tokyonight.nvim'  -- colorscheme

  -- Language Server + Intellisense
  use { 'sheerun/vim-polyglot' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config=function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enabled = true,
          additional_vim_regex_highlighting = true
        },
        indent = { enabled = false }
      }
    end
  }

  -- Fzf
  use { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-project.nvim' }
  }

  -- EasyMotion
  use {
    'phaazon/hop.nvim', as = 'hop',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
end)
