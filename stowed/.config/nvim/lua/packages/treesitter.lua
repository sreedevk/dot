return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local ts       = require 'nvim-treesitter'
      local parsers  = vim.g.enabled_ts_parsers

      local langmaps = {
        { "journal", "ledger" }
      }

      for _, langmap in ipairs(langmaps) do
        vim.treesitter.language.register(langmap[1], langmap[2])
      end

      for _, parser in ipairs(parsers) do
        ts.install(parser)
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers,
        callback = function()
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr       = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.treesitter.start()
        end,
      })
    end
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true,
        disabledDefaults = {
          "r",
          "in",
          "an",
        },
      },
      forwardLooking = {
        small = 5,
        big = 15,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
    branch = "main",
    lazy = true,
    event = "BufReadPost",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      }

      local select = require "nvim-treesitter-textobjects.select"
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "as", function() select.select_textobject("@local.scope", "locals") end)

      -- Swaps
      local swap = require("nvim-treesitter-textobjects.swap")
      vim.keymap.set("n", "<M-0>", function() swap.swap_next "@parameter.inner" end)
      vim.keymap.set("n", "<M-9>", function() swap.swap_previous "@parameter.outer" end)


      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]o",
        function() move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]s", function() move.goto_next_start("@local.scope", "locals") end)
      vim.keymap.set({ "n", "x", "o" }, "]z", function() move.goto_next_start("@fold", "folds") end)

      vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer", "textobjects") end)

      vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end)

      vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer", "textobjects") end)

      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next("@conditional.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous("@conditional.outer", "textobjects") end)

      local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

      vim.keymap.set({ "n", "x", "o" }, "<space>l", ts_repeat_move.repeat_last_move_next, { desc = "Find Repeat Right (;)" })
      vim.keymap.set({ "n", "x", "o" }, "<space>h", ts_repeat_move.repeat_last_move_previous, { desc = "Find Repeat Left (,)" })

      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
  {
    "aaronik/treewalker.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    opts = {
      highlight = true,
      notifications = false,
      select = false,
      highlight_duration = 300,
      highlight_group = 'CursorLine',
      jumplist = true,
      scope_confined = false,
    },
    cmd = { 'Treewalker' },
    keys = {
      { '<C-j>',   ':Treewalker Down<CR>',      mode = { 'n', 'v' }, noremap = true, desc = "Treewalker Down",      silent = true },
      { '<C-k>',   ':Treewalker Up<CR>',        mode = { 'n', 'v' }, noremap = true, desc = "Treewalker Up",        silent = true },
      { '<C-h>',   ':Treewalker Left<CR>',      mode = { 'n', 'v' }, noremap = true, desc = "Treewalker Left",      silent = true },
      { '<C-l>',   ':Treewalker Right<CR>',     mode = { 'v', 'n' }, noremap = true, desc = "Treewalker Right",     silent = true },

      { '<C-S-j>', ':Treewalker SwapDown<CR>',  mode = "n",          noremap = true, desc = "Treesitter SwapUp",    silent = true },
      { '<C-S-k>', ':Treewalker SwapUp<CR>',    mode = "n",          noremap = true, desc = "Treesitter SwapDown",  silent = true },
    },
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    cmd = {
      "TSJJoin",
      "TSJSplit",
      "TSJToggle",
    },
    keys = {
      {
        '<leader><S-j>',
        function() require('treesj').toggle({ split = { recursive = true } }) end,
        noremap = true,
        desc = "TreeSJ Toggle (Recursive)",
      },
      {
        '<leader>j',
        function()
          require('treesj').toggle({ split = { recursive = false } })
        end,
        noremap = true,
        desc = "TreeSJ Toggle",
      },
    },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 512,
      cursor_behavior = 'hold',
      notify = false,
      dot_repeat = true,
      on_error = nil,
    }
  }
}
