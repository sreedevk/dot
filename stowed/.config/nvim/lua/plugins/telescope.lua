return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = "Telescope",
  keys = {
    { "<C-p>",      require('telescope.builtin').find_files,                desc = "Find Files" },
    { '<Leader>rg', require('telescope.builtin').live_grep,                 desc = "Live Grep" },
    { "<C-s>",      "<cmd>Telescope<CR>",                                   desc = "Telescope" },
    { "<Leader>bl", require('telescope.builtin').buffers,                   desc = "Buffer List" },
    { '<Leader>ft', require('telescope.builtin').filetypes,                 desc = "Filetypes List" },
    { '<leader>fh', require('telescope.builtin').help_tags,                 desc = "Help Tags List" },
    { '<leader>gc', require('telescope.builtin').git_commits,               desc = "Git Commit List" },
    { '<Leader>/',  require('telescope.builtin').current_buffer_fuzzy_find, desc = "Current Buff Fuzzy Find" },
    {
      "<Leader>fp",
      function()
        require('telescope.builtin').find_files { cwd = "~/.dot" }
      end,
      desc = "Find Config Files"
    },
    {
      '<Leader>fw',
      function()
        require('telescope.builtin').grep_string({
          search = vim.fn.expand('<cword>'),
        })
      end,
      desc = "Find CWord"
    },
  },
  config = function()
    local t_actions = require("telescope.actions")
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "smart_history")
    pcall(require("telescope").load_extension, "ui-select")

    require("telescope").setup {
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
  end
}
