return {
  "tpope/vim-vinegar",
  'chrisbra/unicode.vim',
  'kevinhwang91/nvim-bqf',
  'preservim/vim-indent-guides',
  'tpope/vim-characterize',
  'tpope/vim-ragtag',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-apathy',

  { "chrisgrieser/nvim-early-retirement", lazy = true,  config = true,  event = "VeryLazy" },
  { 'petertriho/nvim-scrollbar',          lazy = true,  config = true,  event = "BufReadPost" },
  { 'ledger/vim-ledger',                  lazy = true,  config = false, ft = { 'ledger', 'journal' } },
  { "tpope/vim-tbone",                    lazy = true,  config = false, cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" } },
  { "tiagovla/scope.nvim",                lazy = false, config = true },

  {
    'tpope/vim-rails',
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
        pattern = { '*.yml' },
        callback = function()
          vim.bo.filetype = 'yaml'
        end
      })
    end
  },

  {
    'hat0uma/csvview.nvim',
    lazy = true,
    config = true,
    keys = {
      { '<Leader>csv', function() require('csvview').toggle() end, desc = "Toggle CSV View" }
    }
  },

  {
    'tpope/vim-eunuch',
    lazy = false,
    keys = {
      { '<Leader>sw', '<cmd>SudoWrite<cr>', noremap = true, desc = "Sudo Write!" }
    },
    cmd = {
      'Move',
      'Rename',
      'Copy',
      'Duplicate',
      'Remove',
      'Delete',
      'Mkdir',
      'SudoWrite',
      'SudoEdit',
      'Wall',
      'Lfind',
      'Llocate',
      'Cfind',
      'CLocate',
    },
  },

  {
    'chaoren/vim-wordmotion',
    lazy = false,
    init = function()
      vim.g.wordmotion_spaces = { '-', '_', '\\/', '\\.' }
      vim.g.wordmotion_prefix = "<space>"
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    'RaafatTurki/hex.nvim',
    opts = {
      dump_cmd = 'xxd -g 1 -u',
      assemble_cmd = 'xxd -r',
    },
  },

  {
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    config = function()
      vim.opt.spelllang = { "en", "programming" }
    end,
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
      { '<Leader>tm', mode = "n", wrap_cmd("TableModeToggle"), desc = "Vim Table Mode Toggle" },
    }
  },

  {
    'mbbill/undotree',
    lazy = true,
    cmd = "UndotreeToggle",
    keys = {
      { '<Leader>uu', wrap_cmd("UndotreeToggle"), desc = "Toggle Undotree" },
    },
    init = function()
      vim.g.undotree_TreeNodeShape = '◉'
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
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
    keys = {
      { '<Leader>co', wrap_cmd("ColorizerToggle"), desc = "Toggle Colorizer", noremap = true }
    },
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
