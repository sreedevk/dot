local wrap_cmd = require('core.utils').wrap_cmd

return {
  'tpope/vim-apathy',
  'tpope/vim-characterize',
  'tpope/vim-ragtag',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-vinegar',
  'neovim/nvim-lspconfig',

  { "chrisgrieser/nvim-early-retirement", lazy = true,  config = true,  event = "VeryLazy" },
  { 'petertriho/nvim-scrollbar',          lazy = true,  config = true,  event = "BufReadPost" },
  { 'ledger/vim-ledger',                  lazy = true,  config = false, ft = { 'ledger', 'journal' } },
  { "tpope/vim-tbone",                    lazy = true,  config = false, cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" } },
  { "tiagovla/scope.nvim",                lazy = false, config = true },

  {
    'chomosuke/typst-preview.nvim',
    lazy = true,
    ft = 'typst',
    version = '1.*',
    opts = {},
  },

  {
    'declancm/maximize.nvim',
    lazy = true,
    config = true,
    keys = {
      { '<C-w>z', function() require('maximize').toggle() end, desc = "Toggle Split Zoom" }
    }
  },

  {
    'rafcamlet/nvim-luapad',
    cmd = { "Luapad", "LuaRun" },
    lazy = true,
    opts = {
      count_limit = 200000,
      error_indicator = true,
      eval_on_move = false,
      eval_on_change = true,
      error_highlight = 'WarningMsg',
      preview = true,
      split_orientation = 'vertical', -- horizontal
      wipe = true
    },
  },

  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    event = { 'QuickFixCmdPre' },
    ft = 'qf',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'junegunn/fzf'
    },
  },

  {
    'tpope/vim-rails',
    lazy = true,
    ft = { 'ruby' },
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
    lazy = true,
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
    'mattn/emmet-vim',
    lazy = true,
    keys = {
      { "<C-c>", mode = { "i" } },
    },
    ft = {
      "html",
      "eruby",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    init = function()
      vim.g.user_emmet_expandabbr_key = '<C-c>,'
      vim.g.user_emmet_leader_key = '<C-c>'
      vim.g.user_emmet_mode = 'i'
      vim.g.user_emmet_install_global = 1
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
    cmd = { "EasyAlign" },
    keys = {
      {
        'ga',
        '<Plug>(EasyAlign)',
        mode = { 'x', 'n' },
        desc = "EasyAlign",
      },
    },
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
    "XXiaoA/atone.nvim",
    lazy = true,
    cmd = "Atone",
    keys = {
      { '<Leader>uu', wrap_cmd("Atone toggle"), desc = "Undotree" },
    },
    opts = {
      layout = {
        width = 0.15,
      }
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
}
