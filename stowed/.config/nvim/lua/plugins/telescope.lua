return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  cmd = "Telescope",
  keys = {
    { '<C-p>',      require('telescope.builtin').find_files,                desc = 'Find Files' },
    { '<Leader>rg', require('telescope.builtin').live_grep,                 desc = 'Live Grep' },
    { '<C-s>',      '<cmd>Telescope<CR>',                                   desc = 'Telescope' },
    { "<Leader>bl", require('telescope.builtin').buffers,                   desc = 'Buffer List' },
    { '<Leader>ft', require('telescope.builtin').filetypes,                 desc = 'Filetypes List' },
    { '<leader>fh', require('telescope.builtin').help_tags,                 desc = 'Help Tags List' },
    { '<leader>gc', require('telescope.builtin').git_commits,               desc = 'Git Commit List' },
    { '<Leader>/',  require('telescope.builtin').current_buffer_fuzzy_find, desc = 'Current Buff Fuzzy Find' },
    { '<Leader>cc', require('telescope.builtin').commands,                  desc = 'Commands List' },
    { "<Leader>'",  require('telescope.builtin').marks,                     desc = 'Marks List' },
    { "<Leader>sp", require('telescope.builtin').spell_suggest,             desc = 'Suggest Spellings' },
    { "<Leader>tr", "<cmd>Telescope resume<cr>",                            desc = "Resume Last Telescope Search" },
    {
      "<Leader>ej",
      function()
        require 'telescope.builtin'.symbols {
          sources = {
            'emoji',
            'kaomoji',
            'gitmoji',
          },
        }
      end,
      desc = 'Emojis',
    },
    {
      '<Leader>fp',
      function()
        require('telescope.builtin').find_files { cwd = vim.g.dotfiles }
      end,
      desc = 'Find Config Files'
    },
    {
      '<Leader>fw',
      function()
        require('telescope.builtin').grep_string({
          search = vim.fn.expand('<cword>'),
        })
      end,
      desc = 'Find CWord'
    },
  },
  config = function()
    local t_actions = require("telescope.actions")
    require("telescope").setup({
      pickers = {
        live_grep = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<C-w>"] = "delete_buffer",
            },
            n = {
              ["<C-w>"] = "delete_buffer",
            },
          },
        },
        find_files = {
          theme = "ivy",
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--glob",
            "--strip-cwd-prefix",
            "--exclude",
            ".git",
            "--exclude",
            "*.age"
          }
        }
      },
      defaults = {
        file_ignore_patterns = { "dune.lock" },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--no-ignore',
          '--hidden',
          '--glob',
          "!**/.git/*",
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
        mappings = {
          n = {
            ["q"] = t_actions.close,
          },
          i = {
            ["<C-k>"] = t_actions.move_selection_previous,
            ["<C-j>"] = t_actions.move_selection_next,
            ["<esc>"] = t_actions.close,
          },
        }
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
  end
}
