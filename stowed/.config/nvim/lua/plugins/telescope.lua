return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-project.nvim'
  },
  config = function()
    require('telescope').setup {
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
  end
}
