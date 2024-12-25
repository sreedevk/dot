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

  { "chrisgrieser/nvim-early-retirement", lazy = true,  config = true,  event = "VeryLazy" },
  { 'petertriho/nvim-scrollbar',          lazy = true,  config = true,  event = "BufReadPost" },
  { 'chrisbra/csv.vim',                   lazy = true,  config = false, ft = "csv" },
  { 'ledger/vim-ledger',                  lazy = true,  config = false, ft = { 'ledger', 'journal' } },
  { "tpope/vim-tbone",                    lazy = true,  config = false, cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" } },
  { "tiagovla/scope.nvim",                lazy = false, config = true },

  {
    'RaafatTurki/hex.nvim',
    opts = {
      dump_cmd = 'xxd -g 1 -u',
      assemble_cmd = 'xxd -r',
    },
  },

  {
    'lervag/vimtex',
    init = function() vim.g.vimtex_view_method = "zathura" end,
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
    'famiu/bufdelete.nvim',
    lazy = true,
    keys = {
      { "<Leader>bd", [[<cmd>Bdelete<CR>]], desc = "Delete Current Buffer" },
    },
  },

  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    'junegunn/vim-easy-align',
    lazy = true,
    keys = {
      { "<Leader>al", ":EasyAlign", mode = "v", desc = "Init EasyAlign on Selection" }
    },
    cmd = { "EasyAlign" },
  },


  {
    'dhruvasagar/vim-table-mode',
    lazy = true,
    cmd = "TableModeToggle",
    keys = {
      { '<Leader>tm', mode = "n", "<cmd>TableModeToggle<CR>", desc = "Vim Table Mode" },
    }
  },

  {
    'mbbill/undotree',
    lazy = true,
    cmd = "UndotreeToggle",
    keys = {
      { '<Leader>u', "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
    },
  },

  {
    "danymat/neogen",
    lazy = true,
    keys = {
      { '<Leader>ac', function() require("neogen").generate({ type = 'class' }) end, desc = "Annotate Class" },
      { '<Leader>af', function() require("neogen").generate({ type = 'func' }) end,  desc = "Annotate Function" },
      { '<Leader>at', function() require("neogen").generate({ type = 'type' }) end,  desc = "Annotate Type " },
    },
    opts = { snippet_engine = "luasnip" },
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
    "j-hui/fidget.nvim",
    lazy = true,
    tag = 'legacy',
    event = "BufReadPost",
    opts = { window = { blend = 0 } },
  },
}
