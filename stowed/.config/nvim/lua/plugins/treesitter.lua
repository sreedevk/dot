return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    event = "BufReadPost",
    config = function()
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      vim.treesitter.language.register("bash", "apkbuild")
      vim.treesitter.language.register("journal", "ledger")

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "csv",
          "desktop",
          "diff",
          "dockerfile",
          "eex",
          "elixir",
          "erlang",
          "fennel",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "gleam",
          "haskell",
          "haskell_persistent",
          "heex",
          "html",
          "http",
          "hyprlang",
          "janet_simple",
          "javascript",
          "jq",
          "json",
          "latex",
          "ledger",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "nginx",
          "nix",
          "ocaml",
          "ocaml_interface",
          "ocamllex",
          "org",
          "python",
          "ruby",
          "rust",
          "sql",
          "ssh_config",
          "supercollider",
          "tmux",
          "todotxt",
          "toml",
          "tsv",
          "typescript",
          "xml",
          "yaml",
          "zathurarc",
          "zig",
        },
        sync_install = false,
        ignore_install = { "comment" },
        auto_install = false,
        incremental_selection = {
          enable = true,
          disable = vim.g.auxbuffers,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "grn",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        indent = { enable = true },
        refactor = {
          navigation = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            keymaps = {
              goto_definition_lsp_fallback = "gd",
            },
          },
          smart_rename = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            keymaps = {
              smart_rename = "grr",
            },
          },
          highlight_definitions = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            clear_on_cursor_move = true,
            additional_vim_regex_highlighting = false,
          },
        },
        textobjects = {
          swap = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            swap_next = {
              ["<C-.>"] = "@parameter.inner",
            },
            swap_previous = {
              ["<C-,>"] = "@parameter.inner",
            },
          },
          lsp_interop = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>gd"] = "@function.outer",
              ["<leader>gD"] = "@class.outer",
            },
          },
          select = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
          },
          move = {
            enable = true,
            disable = function(lang, bufnr)
              return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
            end,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "next class start" },
            },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, bufnr)
            return lang == 'csv' and vim.api.nvim_buf_line_count(bufnr) > 10000
          end,
        }
      })
    end
  },
  {
    'kana/vim-textobj-user',
    dependencies = { 'kana/vim-operator-user' },
  },
  {
    'glts/vim-textobj-comment',
    dependencies = {
      'kana/vim-textobj-user',
    },
    init = function()
      vim.g.textobj_comment_no_default_key_mappings = 1
    end,
    keys = {
      { 'ac', '<Plug>(textobj-comment-a)', mode = { 'x', 'o' } },
      { 'ic', '<Plug>(textobj-comment-i)', mode = { 'x', 'o' } },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = true,
    event = "BufReadPost",
    ft = { "html", "xml", "erb", "heex" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = true,
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false
      },
      per_filetype = {
        ["html"] = {
          enable_close = false
        }
      }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    event = "BufReadPost"
  },
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    event = "BufReadPost"
  },
  {
    "aaronik/treewalker.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    opts = { highlight = true },
    cmd = { 'Treewalker' },
    keys = {
      { '<C-j>', ':Treewalker Down<CR>', noremap = true, desc = "Treewalker Down", silent = true },
      { '<C-k>', ':Treewalker Up<CR>', noremap = true, desc = "Treewalker Up", silent = true },
      { '<C-h>', ':Treewalker Left<CR>', noremap = true, desc = "Treewalker Left", silent = true },
      { '<C-l>', ':Treewalker Right<CR>', noremap = true, desc = "Treewalker Right", silent = true },
      { '<C-S-j>', ':Treewalker SwapDown<CR>', noremap = true, desc = "Treesitter SwapUp", silent = true },
      { '<C-S-k>', ':Treewalker SwapUp<CR>', noremap = true, desc = "Treesitter SwapDown", silent = true }
    },
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    event = "BufReadPost",
    keys = {
      { '<leader>j', [[<cmd>TSJToggle<cr>]], noremap = true, desc = "TreeSJ" },
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
