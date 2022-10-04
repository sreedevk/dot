vim.cmd('packadd packer.nvim')

return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- plugin manager
  use 'mattn/emmet-vim'        -- html emmets
  use 'sjl/gundo.vim'          -- undo tree
  use 'hoob3rt/lualine.nvim'   -- statusline
  use 'tpope/vim-fugitive'     -- git
  use 'tpope/vim-rails'        -- rails support
  use 'tpope/vim-surround'     -- ysiw
  use 'folke/tokyonight.nvim'  -- colorscheme
  use 'dhruvasagar/vim-table-mode'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }, -- optional, for file icons
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          mappings = {
            list = {
              { key = "u", action = "dir_up" },
              { key = "T", action = "tabnew" },
              { key = "<C-t>", action = "" }
            },
          },
        },
        renderer = {
          group_empty = true,
        },
      })
    end
  }


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
