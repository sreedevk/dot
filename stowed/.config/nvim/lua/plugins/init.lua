return {
  'chrisbra/unicode.vim',
  'kevinhwang91/nvim-bqf',
  'mattn/emmet-vim',
  'tpope/vim-characterize',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-ragtag',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  'preservim/vim-indent-guides',
  'tpope/vim-surround',
  'lervag/vimtex',

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  },

  {
    'famiu/bufdelete.nvim',
    keys = { "<Leader>bd" },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>bd', [[<cmd>Bdelete<CR>]], { noremap = true })
    end
  },

  {
    'nanotee/zoxide.vim',
    dependencies = {
      'junegunn/fzf',
      'junegunn/fzf.vim'
    },
    keys = { '<Leader>zi', '<Leader>zz' },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>zi', [[<cmd>Zi<cr>]], { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>zz', ':Z ', { noremap = true })
    end
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { "<Leader>al", mode = "v" }
    },
    cmd = { "EasyAlign" },
    config = function()
      vim.api.nvim_set_keymap('v', '<Leader>al', ":EasyAlign", { noremap = true })
    end
  },
  {
    'chrisbra/csv.vim',
    lazy = true,
    ft = "csv"
  },

  {
    'dhruvasagar/vim-table-mode',
    lazy = true,
    cmd = "TableModeToggle",
    keys = { '<Leader>tm' },
    config = function()
      vim.api.nvim_set_keymap('v', '<Leader>tm', "<cmd>TableModeToggle<CR>", { noremap = true })
    end
  },

  {
    'mbbill/undotree',
    lazy = true,
    cmd = "UndotreeToggle",
    keys = { '<Leader>u' },
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>u', "<cmd>UndotreeToggle<CR>", { noremap = true })
    end
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
    keys = { '<Leader>tz' },
    config = function()
      require('zen-mode').setup()

      vim.api.nvim_set_keymap('v', '<Leader>tz', "<cmd>ZenMode<CR>", { noremap = true })
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
