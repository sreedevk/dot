return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-project.nvim'
  },
  keys = {
    {'<C-p>', '<cmd>Telescope find_files<CR>', desc = 'find files' },
    {'<C-b>', '<cmd>Telescope buffers<CR>', desc = 'find buffers' },
    {'<C-s>', '<cmd>Telescope<CR>', desc = 'find pickers' },
    {'<Leader>rg', '<cmd>Telescope live_grep<CR>', desc = 'live grep' },
    {'<Leader>gr', '<cmd>Telescope grep_string<CR>', desc = 'grep string under word' },
    {'<Leader>pp', ":lua require'telescope'.extensions.project.project{}<CR>", desc = 'list projects' },
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
