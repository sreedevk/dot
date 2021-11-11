require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<esc>"] = require('telescope.actions').close,
      }
    }
  },
  pickers = {},
  extensions = {}
}
