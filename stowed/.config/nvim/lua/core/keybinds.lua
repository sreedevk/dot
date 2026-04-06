-- Resize Splits {{{1
vim.keymap.set("n", "<M-,>", "<c-w>5<", { noremap = true, desc = "decrease width of current window" })
vim.keymap.set("n", "<M-.>", "<c-w>5>", { noremap = true, desc = "increase width of current window" })
vim.keymap.set("n", "<M-d>", "<C-W>+", { noremap = true, desc = "Increase height of current window" })
vim.keymap.set("n", "<M-u>", "<C-W>-", { noremap = true, desc = "Increase height of current window" })

-- Navigate Splits {{{1
vim.keymap.set("n", "<left>", "<c-w>h", { noremap = true, desc = "switch to window on left" })
vim.keymap.set("n", "<right>", "<c-w>l", { noremap = true, desc = "switch to window on right" })
vim.keymap.set("n", "<down>", "<C-w>j", { noremap = true, desc = "switch to window above" })
vim.keymap.set("n", "<up>", "<C-w>k", { noremap = true, desc = "switch to window below" })
vim.keymap.set("n", "]w", "<C-w>l", { noremap = true, desc = "switch to window on right" })
vim.keymap.set("n", "[w", "<C-w>h", { noremap = true, desc = "switch to window on left" })

-- Tab Management {{{1
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { noremap = true, desc = "create a new tab" })
vim.keymap.set('n', '<Leader>tx', "<cmd>tabonly<cr>", { noremap = true, desc = "delete all other tabs" })
vim.keymap.set('n', '<Leader>ww', '<cmd>vnew<cr>', { noremap = true, desc = "new vertical window" })
vim.keymap.set('n', '<Leader>ws', '<cmd>new<cr>', { noremap = true, desc = "new horizontal window" })
vim.keymap.set('n', '<C-w>v', "<cmd>vnew<cr>", { noremap = true, desc = "new vertical window" })
vim.keymap.set('n', '<C-w>s', "<cmd>new<cr>", { noremap = true, desc = "new horizontal window" })
vim.keymap.set('n', '<Leader>te', "<cmd>term<cr>", { noremap = true, desc = "open terminal buffer" })

-- Buffer Navigation {{{1
vim.keymap.set('n', '<Leader>bb', '<cmd>bnext<CR>', { noremap = true, desc = "switch to next buffer" })
vim.keymap.set('n', '<Leader>bB', '<cmd>bprev<CR>', { noremap = true, desc = "switch to previous buffer" })
vim.keymap.set('n', '<M-[>', '<cmd>bprev<CR>', { noremap = true, desc = "switch to previous buffer" })
vim.keymap.set('n', '<M-]>', '<cmd>bnext<CR>', { noremap = true, desc = "switch to next buffer" })
vim.keymap.set('n', '<Leader>cx', '<cmd>! chmod +x %<CR>', { noremap = true, desc = "add +x permission for file" })
vim.keymap.set('n', '<leader>ssp', '<cmd>set spell!<CR>', { noremap = true, desc = "enable spell check" })

vim.keymap.set(
  { 'n' },
  '<Leader>bo',
  '<cmd>silent w|silent %bd|silent e#|silent bd#<CR>',
  {
    noremap = true,
    desc = "close all buffers except current buffer",
  }
)

vim.keymap.set(
  'n',
  '<Leader>bo',
  require('core.utils').force_early_retire_buffers,
  { noremap = true, desc = "close all buffers." }
)

-- Sorting {{{1
vim.keymap.set({ 'v', 'n' }, '<Leader>srr', ":sort<cr>", { noremap = true, desc = "sort lines" })
vim.keymap.set({ 'v', 'n' }, '<Leader>srn', ":sort n<cr>", { noremap = true, desc = "sort lines numerically" })
vim.keymap.set({ 'v', 'n' }, '<Leader>sru', ":sort u<cr>", { noremap = true, desc = "sort lines unique" })

-- Neovim Lua Helpers {{{1
vim.keymap.set('v', '<Leader>la', ':lua<CR>', { noremap = true, desc = "eval selection in nvim lua rt" })
vim.keymap.set("n", "<leader>la", "<cmd>.lua<CR>", { noremap = true, desc = "eval line in nvim lua rt" })
vim.keymap.set("n", "<leader><leader>la", "<cmd>source %<CR>", { noremap = true, desc = "eval buffer in nvim lua rt" })


-- QuickfixList {{{1
vim.keymap.set({ "n" }, "<leader>co", "<cmd>copen<cr>", { noremap = true, desc = "open quickfixlist" })
vim.keymap.set({ "n" }, "<leader>cc", "<cmd>cclose<cr>", { noremap = true, desc = "close quickfixlist" })

-- Leader Key Role Fix {{{1
vim.keymap.set('n', ';', '<Nop>', { noremap = true })
vim.keymap.set('n', '<space>l', ';', { noremap = true, desc = "Find Repeat Right (;)" })
vim.keymap.set('n', '<space>h', ',', { noremap = true, desc = "Find Repeat Left (,)" })

-- Misc {{{1
vim.keymap.set('n', '<leader><leader>e', ':', { noremap = true, desc = "command mode" })
vim.keymap.set('t', "<C-\\><C-\\>", "<C-\\><C-n>", { noremap = true, desc = "escape terminal mode" })
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { noremap = true, desc = "no highlights" })
vim.keymap.set('n', '<Leader>h', '<cmd>noh<CR>', { noremap = true, desc = "no highlights" })
vim.keymap.set('n', '<Leader>rr', '<cmd>e!<CR>', { noremap = true, desc = "reload buffer from file on disk" })
vim.keymap.set('n', '<Leader>fs', '<cmd>w<CR>', { noremap = true, desc = "save file" })
vim.keymap.set('n', '<Leader>q', '<cmd>q<CR>', { noremap = true, desc = "quit neovim" })
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
vim.keymap.set('v', '<Leader>lc', [[<cmd>echo line("'>") - line("'<") + 1<CR>]],
  { noremap = true, desc = "Count Selected Lines" })

-- Copied from helix
vim.keymap.set('n', 'U', vim.cmd.redo, { desc = "redo", noremap = true })
vim.keymap.set('n', 'gh', '<cmd>normal _<cr>', { desc = "beginning of line", noremap = true })
vim.keymap.set('n', 'gl', '<cmd>normal $<cr>', { desc = "end of line", noremap = true })

vim.keymap.set(
  { 'n' },
  '<Leader>ex',
  function()
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_command('vsplit | term ' .. line)
  end,
  { noremap = true, desc = "execute current line in :term" }
)

vim.keymap.set(
  { 'n' },
  '<Leader>vh',
  function() vim.cmd("h " .. vim.fn.expand('<cword>')) end,
  { noremap = true, desc = "search cword in vim help" }
)

vim.keymap.set(
  { 'n' },
  '<Leader>cd',
  function() vim.cmd('tcd ' .. vim.fn.expand('%:p:h')) end,
  { noremap = true, desc = "change directory to current file's parent" }
)

vim.keymap.set('n', '<leader>xo', function()
  local file = vim.fn.expand('%:p')
  local url = 'file://' .. file

  vim.notify('opened in browser: ' .. url, vim.log.levels.INFO)
  vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
end, { desc = 'open current file in browser', noremap = true, silent = true })

vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

vim.keymap.set("v", "<tab>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

vim.keymap.set({ "n", "x", "o" }, "<A-i>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })


vim.keymap.set("v", "<S-tab>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

-- vim:foldmethod=marker
