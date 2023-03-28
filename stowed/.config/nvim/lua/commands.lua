local api = vim.api
local helpers = require("helpers")

api.nvim_create_user_command('W', 'w', {})
api.nvim_create_user_command('Wq', 'wq', {})
api.nvim_create_user_command('WQ', 'wq', {})
api.nvim_create_user_command('Q', 'q', {})
api.nvim_create_user_command('Filetypes', 'Telescope filetypes', {})
api.nvim_create_user_command('ToggleVenn', ":lua require('utils').toggle_venn()", {})
api.nvim_create_user_command('CmdRun', ":lua require('utils').prun()", {})
api.nvim_create_user_command('EmptySwap', ":lua require('utils').emptyswap()", {})
api.nvim_create_user_command(
  'WipeReg',
  'for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor',
  {}
)

local auto_commands = {
  yank_highlight = {
    { "TextYankPost", "*", "silent! lua vim.highlight.on_yank()" }
  },
  notes = {
    {
      { "BufRead", "BufNewFile" },
      { "*.norg",  "*.org" },
      "silent! TableModeEnable"
    }
  },
  csv_filetypes = {
    {
      { "BufRead", "BufNewFile" },
      { "*.csv", "*.CSV" },
      "set filetype=csv"
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
