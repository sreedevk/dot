local api = vim.api
local autocmd = api.nvim_create_autocmd
local usercmd = api.nvim_create_user_command

usercmd('W', 'w', {})
usercmd('Wq', 'wq', {})
usercmd('WQ', 'wq', {})
usercmd('Q', 'q', {})
usercmd('Filetypes', 'Telescope filetypes', {})
usercmd('ToggleVenn', ":lua require('utils').toggle_venn()", {})
usercmd('EmptySwap', ":lua require('utils').emptyswap()", {})
usercmd(
  'WipeReg',
  'for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor',
  {}
)

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local_buflisted = false
  end
})

autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.norg", "*.org" },
  command = "silent! TableModeEnable"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.norg", "*.org" },
  command = "silent! TableModeEnable"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.csv", "*.CSV" },
  command = "set filetype=csv"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ex", "*.exs" },
  command = "set filetype=elixir"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.eex", "*.heex", "*.leex", "*.sface", "*.lexs" },
  command = "set filetype=heex"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "mix.lock",
  command = "set filetype=elixir"
})


autocmd("FileType", {
  pattern = {
    "qf", "help", "man", "notify", "nofile",
    "lspinfo", "terminal", "prompt", "toggleterm",
    "startuptime", "tsplayground", "PlenaryTestPopup"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
  end,
})
