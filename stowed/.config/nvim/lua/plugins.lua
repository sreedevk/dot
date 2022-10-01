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
  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true }) 
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        sync_install     = false,
        auto_install     = true,
        highlight        = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = { enable = true }
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
