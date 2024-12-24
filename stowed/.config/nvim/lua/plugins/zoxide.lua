return {
  'nanotee/zoxide.vim',
  dependencies = {
    'junegunn/fzf',
    'junegunn/fzf.vim'
  },
  cmd = { "Z", "Zi", "Tzi", "Tz" },
  keys = {
    { '<Leader>zi', [[<cmd>Tzi<cr>]], noremap = true, desc = "Zoxide Interactive" },
    { '<Leader>zz', ":Tz",            noremap = true, desc = "Zoxide CD" },
  },
}
