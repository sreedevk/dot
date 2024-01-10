return {
  'tpope/vim-surround',
  'tpope/vim-characterize',
  'tpope/vim-fugitive',
  'tpope/vim-rails',
  'tpope/vim-ragtag',
  'mattn/emmet-vim',
  'chrisbra/unicode.vim',
  'tpope/vim-repeat',
  'kevinhwang91/nvim-bqf',
  'famiu/bufdelete.nvim',
  'nanotee/zoxide.vim',
  'xarthurx/taskwarrior.vim',
  {
    'chrisbra/csv.vim',
    lazy = true,
    ft = "csv"
  },

  {
    'dhruvasagar/vim-table-mode',
    lazy = true,
    cmd = "TableModeToggle"
  },

  {
    'mbbill/undotree',
    lazy = true,
    cmd = "UndotreeToggle",
  },

  {
    "tpope/vim-tbone",
    lazy = true,
    cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" }
  },
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
      'ColorizerToggle'
    },
    config = function()
      require('colorizer').setup()
    end
  },

  {
    'jdhao/better-escape.vim',
    lazy = true,
    event = { "CursorHold", "CursorHoldI" }
  },

  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end
  },

  {
    "j-hui/fidget.nvim",
    lazy = true,
    tag = 'legacy',
    event = "BufReadPost",
    config = function()
      require("fidget").setup({
        window = {
          blend = 0,
        },
      })
    end
  },

  {
    'petertriho/nvim-scrollbar',
    lazy = true,
    event = "BufReadPost",
    config = function()
      require('scrollbar').setup()
    end
  },

  {
    'folke/zen-mode.nvim',
    lazy = true,
    cmd = "ZenMode",
    config = function()
      require('zen-mode').setup()
    end
  },

  {
    'folke/twilight.nvim',
    lazy = true,
    cmd = { "ZenMode", "Twilight", "TwilightEnable", "TwilightDisable" },
    dependencies = { 'folke/zen-mode.nvim' },
    config = function()
      require('twilight').setup()
    end
  },

  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
        map_cr = true
      }
    end
  },

  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    version = '*',
    cmd = "ToggleTerm",
    config = function()
      require('toggleterm').setup()
    end
  },

  {
    'echasnovski/mini.comment',
    lazy = true,
    keys = {
      "gcE",
      { "gc", mode = "v" }
    },
    config = function()
      require('mini.comment').setup()
    end
  },

  {
    'Wansmer/treesj',
    keys = { '<leader>j' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({})
    end,
  },

  {
    'ledger/vim-ledger',
    ft = { 'ledger', 'journal' },
  },

  {
    "tiagovla/scope.nvim",
    config = function ()
      require("scope").setup()
    end
  }
}
