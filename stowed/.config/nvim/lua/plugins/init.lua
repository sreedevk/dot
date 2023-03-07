return {
  'wbthomason/packer.nvim',
  'mattn/emmet-vim',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-characterize',
  'windwp/nvim-ts-autotag',
  'nvim-lua/plenary.nvim',
  'nathom/filetype.nvim',
  'mbbill/undotree',
  {
    'dhruvasagar/vim-table-mode',
    keys = {
      { '<Leader>tm', "<cmd>TableModeToggle<CR>", desc = "table mode" }
    }
  },
  {
    'glepnir/lspsaga.nvim',
    branch = 'main'
  },
  {
    'jdhao/better-escape.vim',
    event = 'InsertEnter'
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  },
  {
    'stevearc/aerial.nvim',
    keys = {
      { '<Leader>cv', '<cmd>AerialToggle<CR>', desc = "aerial toggle" }
    },
    config = function()
      require('aerial').setup()
    end
  },
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<Leader>z', '<cmd>ZenMode<CR>', desc = "zen mode" }
    },
    config = function()
      require('zen-mode').setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
        map_cr = false
      }
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<Leader>t',  "<cmd>ToggleTerm<CR>" },
      { '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>" }
    },
    config = function()
      require('toggleterm').setup()
    end
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end
  },
  {
    'echasnovski/mini.comment',
    config = function()
      require('mini.comment').setup()
    end
  },
  {
    'echasnovski/mini.move',
    config = function()
      require('mini.move').setup()
    end
  }
}
