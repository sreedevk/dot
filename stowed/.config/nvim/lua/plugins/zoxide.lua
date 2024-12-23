return {
  'nanotee/zoxide.vim',
  dependencies = {
    'junegunn/fzf',
    'junegunn/fzf.vim'
  },
  cmd = { "Z", "Zi" },
  keys = { '<Leader>zi', '<Leader>zz' },
  config = function()
    vim.keymap.set('n', '<Leader>zi', [[<cmd>Tzi<cr>]], { noremap = true })
    vim.keymap.set('n', '<Leader>zz', ':Tz ', { noremap = true })
  end
}
