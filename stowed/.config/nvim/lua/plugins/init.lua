return {
  'chrisbra/unicode.vim',
  'famiu/bufdelete.nvim',
  'kevinhwang91/nvim-bqf',
  'mattn/emmet-vim',
  'tpope/vim-characterize',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-ragtag',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  'jbyuki/venn.nvim',
  'tpope/vim-surround',
  'lervag/vimtex',
  {
    'nanotee/zoxide.vim',
    dependencies = {
      'junegunn/fzf',
      'junegunn/fzf.vim'
    }
  },
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
    "danymat/neogen",
    config = true,
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
    config = true
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
    config = function()
      require("scope").setup()
    end
  }
}
