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

    telescope.setup {
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        }
      },
      defaults = {
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

    vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files() end, { noremap = true })
    vim.keymap.set('n', '<C-s>', "<cmd>Telescope<CR>", { noremap = true })
    vim.keymap.set('n', '<Leader>rg', function() require('telescope.builtin').live_grep() end, { noremap = true })
    vim.keymap.set('n', '<Leader>bl', function() require('telescope.builtin').buffers() end, { noremap = true })
    vim.keymap.set('n', '<Leader>ft', function() require('telescope.builtin').filetypes() end, { noremap = true })
    vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { noremap = true })
    vim.keymap.set('n', '<leader>gc', function() require('telescope.builtin').git_commits() end, { noremap = true })

    vim.keymap.set('n', '<Leader>fw', function()
      require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
    end, { noremap = true })
  end
}
