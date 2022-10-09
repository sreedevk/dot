vim.cmd('packadd packer.nvim')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- plugin manager
  use 'mattn/emmet-vim'        -- html emmets
  use 'hoob3rt/lualine.nvim'   -- statusline
  use 'tpope/vim-fugitive'     -- git
  use 'tpope/vim-rails'        -- rails support
  use 'tpope/vim-surround'     -- ysiw
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use 'Shatur/neovim-ayu'
  use 'dhruvasagar/vim-table-mode'

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = false,
      }
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        map_cr = false
      }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }, -- optional, for file icons
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  }

  -- Language Server + Intellisense
  use { 'sheerun/vim-polyglot' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
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

  use {
    'jedrzejboczar/possession.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
end)
