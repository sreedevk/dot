return {
  "tpope/vim-vinegar",
  'chrisbra/unicode.vim',
  'kevinhwang91/nvim-bqf',
  'preservim/vim-indent-guides',
  'tpope/vim-characterize',
  'tpope/vim-dispatch',
  'tpope/vim-ragtag',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  'tpope/vim-surround',

  {
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },

  {
    'mattn/emmet-vim',
    lazy = true,
    keys = {
      { "<C-c>", mode = { "i" } },
    },
    ft = { "html", "erb", "javascript", "typescript" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-c>"
    end
  },

  {
    "gpanders/nvim-parinfer",
    config = function()
      vim.g.parinfer_filetypes = {
        "dune",
        "scheme",
        "query",
        "racket",
        "clojure"
      }
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    ft = { "markdown", "lsp_markdown" },
    cmd = { "EasyAlign" },
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
  },

  {
    'famiu/bufdelete.nvim',
    lazy = true,
    keys = { "<Leader>bd" },
    config = function()
      vim.keymap.set('n', '<Leader>bd', [[<cmd>Bdelete<CR>]], { noremap = true })
    end
  },

  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },

  {
    'junegunn/vim-easy-align',
    lazy = true,
    keys = {
      { "<Leader>al", mode = "v" }
    },
    cmd = { "EasyAlign" },
    config = function()
      vim.keymap.set('v', '<Leader>al', ":EasyAlign", { noremap = true })
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
      vim.keymap.set('v', '<Leader>tm', "<cmd>TableModeToggle<CR>", { noremap = true })
    end
  },

  {
    'mbbill/undotree',
    lazy = true,
    cmd = "UndotreeToggle",
    keys = { '<Leader>u' },
    config = function()
      vim.keymap.set('n', '<Leader>u', "<cmd>UndotreeToggle<CR>", { noremap = true })
    end
  },

  {
    "danymat/neogen",
    lazy = true,
    keys = { '<Leader>ac', '<Leader>af', '<Leader>at' },
    config = function()
      local neogen = require('neogen')

      neogen.setup({ snippet_engine = "luasnip" })
      vim.keymap.set('n', '<Leader>ac', function() neogen.generate({ type = 'class' }) end)
      vim.keymap.set('n', '<Leader>af', function() neogen.generate({ type = 'func' }) end)
      vim.keymap.set('n', '<Leader>at', function() neogen.generate({ type = 'type' }) end)
    end,
  },

  {
    "tpope/vim-tbone",
    lazy = true,
    cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" }
  },

  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    ft = { "css", "scss", "less" },
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
      'ColorizerToggle'
    },
    config = true
  },

  {
    'jdhao/better-escape.vim',
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    init = function()
      vim.g.better_escape_shortcut = 'jj'
      vim.g.better_escape_interval = 400
    end
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true
  },

  {
    "j-hui/fidget.nvim",
    lazy = true,
    tag = 'legacy',
    event = "BufReadPost",
    opts = {
      window = {
        blend = 0,
      },
    },
  },

  {
    'petertriho/nvim-scrollbar',
    lazy = true,
    event = "BufReadPost",
    config = true,
  },

  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    config = true
  },

  {
    'ledger/vim-ledger',
    lazy = true,
    ft = { 'ledger', 'journal' },
  },

  {
    "tiagovla/scope.nvim",
    config = true
  }
}
