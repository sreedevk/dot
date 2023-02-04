local api = vim.api

api.nvim_create_user_command('W', 'w', {})
api.nvim_create_user_command('Wq', 'wq', {})
api.nvim_create_user_command('WQ', 'wq', {})
api.nvim_create_user_command('Q', 'q', {})
api.nvim_create_user_command('Filetypes', 'Telescope filetypes', {})
api.nvim_create_user_command('Resource', 'source ~/.config/nvim/init.lua', {})
api.nvim_create_user_command(
  'WipeReg',
  'for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor',
  {}
)

local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

vim.cmd [[
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=heex
  au BufRead,BufNewFile mix.lock set filetype=elixir
]]
