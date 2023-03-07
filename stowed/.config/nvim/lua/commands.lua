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

local helpers_ok, helpers = pcall(require, "helpers")
if not helpers_ok then
  return
end

local auto_commands = {
  yank_highlight = {
    { "TextYankPost", "*", "silent! lua vim.highlight.on_yank()" }
  },
  notes = {
    {
      { "BufRead", "BufNewFile" },
      ".norg",
      "silent! TableModeEnable"
    }
  },
  eex_corrections = {
    {
      { "BufRead", "BufNewFile" },
      { "*.ex",    "*.exs" },
      "set filetype=elixir"
    },
    {
      { "BufRead", "BufNewFile" },
      { "*.eex",   "*.heex",    "*.leex", "*.sface", "*.lexs" },
      "set filetype=heex"
    },
    {
      { "BufRead", "BufNewFile" },
      "mix.lock",
      "set filetype=elixir"
    }
  }
}

helpers.create_augroups(auto_commands)
