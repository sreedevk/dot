return {
  'tpope/vim-surround',
  'tpope/vim-characterize',
  'nathom/filetype.nvim',
  'jbyuki/venn.nvim',
  'mattn/emmet-vim',

  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = {
      "Git",
      "G",
      "Gvdiffsplit",
      "Gdiffsplit",
    }
  },

  {
    'chrisbra/csv.vim',
    laxy = true,
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
    'rafcamlet/nvim-luapad',
    lazy = true,
    cmd = { "Luapad", "LuaRun" },
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
    "tversteeg/registers.nvim",
    name = "registers",
    lazy = true,
    keys = {
      { "\"",    mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    cmd = "Registers",
  },

  {
    'rainbowhxch/accelerated-jk.nvim',
    lazy = true,
    event = "VeryLazy",
    config = function()
      require('accelerated-jk').setup()
    end
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
    event = "BufReadPost",
    config = function()
      require("fidget").setup({})
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
    config = function()
      require('mini.comment').setup()
    end
  },

  {
    'echasnovski/mini.jump',
    config = function()
      require('mini.jump').setup({
        mappings = { forward = 'f', backward = 'F', forward_till = 't', backward_till = 'T', repeat_jump = '' },
        delay = {
          highlight = 250,
          idle_stop = 10000000,
        },
      })
    end
  },

  {
    "monaqa/dial.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    dependencies = "nvim-lua/plenary.nvim",
  },
}
