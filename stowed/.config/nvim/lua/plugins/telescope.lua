return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'LinArcX/telescope-env.nvim',
    'ahmedkhalf/project.nvim',
    {
      dependencies = { "kkharji/sqlite.lua" }
    }
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    local t_actions = require("telescope.actions")
    telescope.setup {
      pickers = {
        find_files = {
          hidden = false,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        }
      },
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = false,
        }
      },
      defaults = {
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

    telescope.load_extension "env"
    telescope.load_extension "projects"
  end
}
