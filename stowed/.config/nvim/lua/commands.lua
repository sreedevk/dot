local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

usercmd('W', 'w', {})
usercmd('Wq', 'wq', {})
usercmd('WQ', 'wq', {})
usercmd('Q', 'q', {})

usercmd('FetchUrl', ':lua require("utils").fetchjson()', {})
usercmd('Camelize', ':lua require("utils").convert_cword_to_camel()', {})
usercmd('Snakeize', ':lua require("utils").convert_cword_to_snake()', {})


autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local_buflisted = false
  end
})

autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    local function extend_hl(name, def)
      local old = vim.api.nvim_get_hl_by_name(name, true)
      local new = vim.tbl_extend("force", {}, old, def)
      vim.api.nvim_set_hl(0, name, new)
    end
    extend_hl("@keyword.function.ruby", { bold = true })
    extend_hl("@keyword.conditional.ruby", { bold = true })
  end
})

autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()"
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
  pattern = { "*.journal", "*.prices", "*.ledger" },
  command = "set filetype=ledger"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.envrc" },
  command = "set filetype=bash"
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
  pattern = "*",
  command = "setlocal formatoptions-=o"
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
