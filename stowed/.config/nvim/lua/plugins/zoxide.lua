return {
  'nanotee/zoxide.vim',
  dependencies = {
    'junegunn/fzf',
    'junegunn/fzf.vim'
  },
  cmd = { "Z", "Zi" },
  keys = { '<Leader>zi', '<Leader>zz' },
  config = function()
    vim.api.nvim_set_keymap('n', '<Leader>zi', [[<cmd>Tzi<cr>]], { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>zz', ':Tz ', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>fp', [[<cmd>Tz ~/.dot<cr>]], { noremap = true })
  end
}
