return {
  'nanotee/zoxide.vim',
  dependencies = {
    'junegunn/fzf',
    'junegunn/fzf.vim'
  },
  cmd = { "Z", "Zi" },
  keys = { '<Leader>zi', '<Leader>zz' },
  config = function()
    vim.api.nvim_set_keymap('n', '<Leader>zi', [[<cmd>Zi<cr>]], { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>zz', ':Z ', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>fp', [[<cmd>Z ~/.dot<cr>]], { noremap = true })
  end
}
