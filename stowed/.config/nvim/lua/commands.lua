-- PLUGIN / INBUILD COMMAND MAPPINGS
local api = vim.api

api.nvim_create_augroup("packer_user_config", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerSync",
  group = "packer_user_config",
  pattern = "plugins.lua"
})

api.nvim_create_user_command('W', 'w', {})
api.nvim_create_user_command('Wq', 'wq', {})
api.nvim_create_user_command('WQ', 'wq', {})
api.nvim_create_user_command('Q', 'q', {})
api.nvim_create_user_command('Filetypes', 'Telescope filetypes', {})
api.nvim_create_user_command('Resource', 'source ~/.config/nvim/init.lua', {})
api.nvim_create_user_command('T', 'tabedit <args>', { nargs = 1, complete = "file" })
api.nvim_create_user_command(
  'WipeReg',
  'for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor',
  {}
)
