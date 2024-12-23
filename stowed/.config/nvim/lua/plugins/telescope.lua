return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = "Telescope",
  keys = { "<C-p>", "<Leader>p", "<C-s>", "<leader>fw", "<Leader>rg", "<Leader>bl" },
  config = function()
    local telescope = require("telescope")
    local t_actions = require("telescope.actions")
    local builtin = require "telescope.builtin"

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "smart_history")
    pcall(require("telescope").load_extension, "ui-select")

    telescope.setup {
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
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
          '--hidden'
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
    }

    vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files() end)
    vim.keymap.set('n', '<C-s>', "<cmd>Telescope<CR>")
    vim.keymap.set('n', '<Leader>rg', builtin.live_grep)
    vim.keymap.set('n', '<Leader>bl', builtin.buffers)
    vim.keymap.set('n', '<Leader>ft', builtin.filetypes)
    vim.keymap.set('n', '<leader>fh', builtin.help_tags)
    vim.keymap.set('n', '<leader>gc', builtin.git_commits)
    vim.keymap.set("n", '<Leader>/', builtin.current_buffer_fuzzy_find)

    vim.keymap.set('n', '<Leader>fw', function()
      require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
    end)

    vim.keymap.set("n", "<Leader>fp", function()
      builtin.find_files { cwd = "~/.dot" }
    end)
  end
}
