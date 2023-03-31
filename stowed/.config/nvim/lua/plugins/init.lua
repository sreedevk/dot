return {
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-characterize',
  'nathom/filetype.nvim',
  'jbyuki/venn.nvim',
  'mattn/emmet-vim',
  { 'chrisbra/csv.vim', ft="csv" },

  { 'dhruvasagar/vim-table-mode', cmd = "TableModeToggle" },
  { 'mbbill/undotree',            cmd = "UndotreeToggle" },
  { 'jdhao/better-escape.vim',    event = 'InsertEnter' },
  { "tpope/vim-tbone",            cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" } },
  { 'rafcamlet/nvim-luapad',      cmd = { "Luapad", "LuaRun" } },

  {
    'norcalli/nvim-colorizer.lua',
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
    "tversteeg/registers.nvim",
    name = "registers",
    keys = {
      { "\"",    mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    cmd = "Registers",
  },

  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  },

  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end
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
    'folke/twilight.nvim',
    cmd = { "ZenMode", "Twilight", "TwilightEnable", "TwilightDisable" },
    dependencies = { 'folke/zen-mode.nvim' },
    config = function()
      require('twilight').setup()
    end
  },

  {
    'windwp/nvim-autopairs',
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
  }
}
