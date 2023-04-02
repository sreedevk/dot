return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'LinArcX/telescope-env.nvim',
    {
      'nvim-telescope/telescope-frecency.nvim',
      dependencies = { "kkharji/sqlite.lua" }
    }
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    telescope.setup {
      extensions = {
        file_browser = {
          theme = 'ivy',
          hijack_netrw = false,
          mappings = {
                ["i"] = {
                  ["<C-k>"] = require('telescope.actions').move_selection_previous,
                  ["<C-j>"] = require('telescope.actions').move_selection_next,
                  ["<esc>"] = require('telescope.actions').close,
            }
          }
        }
      },
      defaults = {
        mappings = {
          i = {
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<esc>"] = require('telescope.actions').close,
          }
        }
      },
    }

    telescope.load_extension "file_browser"
    telescope.load_extension "frecency"
    telescope.load_extension "env"
  end
}
