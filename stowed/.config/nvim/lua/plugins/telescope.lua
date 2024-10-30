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


    vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>Telescope find_files<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>p', "<cmd>Telescope git_files<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s>', "<cmd>Telescope<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>rg', "<cmd>Telescope live_grep<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>fw',
      "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>bl', "<cmd>Telescope buffers<CR>", { noremap = true })

    vim.api.nvim_create_user_command('Filetypes', 'Telescope filetypes', {})
  end
}
