return {
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-characterize',
  'nathom/filetype.nvim',
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end
  },
  {
    'mbbill/undotree',
    cmd = "UndotreeToggle"
  },
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    cmd = {
      "YAMLView",
      "YAMLYank",
      "YAMLYankKey",
      "YAMLYankValue",
      "YAMLQuickfix",
      "YAMLTelescope"
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim"
    },
  },
  {
    'dhruvasagar/vim-table-mode',
    cmd = "TableModeToggle"
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
    'folke/zen-mode.nvim',
    cmd = "ZenMode",
    config = function()
      require('zen-mode').setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
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
    cmd = "ToggleTerm",
    config = function()
      require('toggleterm').setup()
    end
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  },
  {
    'echasnovski/mini.comment',
    config = function()
      require('mini.comment').setup()
    end
  },
}
