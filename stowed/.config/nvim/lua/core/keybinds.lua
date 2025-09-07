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
vim.keymap.set('n', '<Leader>bD', '<cmd>w|%bd|e#<CR>', { noremap = true, desc = "close buffers in the background" })
vim.keymap.set('n', '<Leader>cx', '<cmd>! chmod +x %<CR>', { noremap = true, desc = "add +x permission for file" })
vim.keymap.set('n', '<leader>ssp', '<cmd>set spell!<CR>', { noremap = true, desc = "enable spell check" })

-- Sorting {{{1
vim.keymap.set({ 'v', 'n' }, '<Leader>srr', ":sort<cr>", { noremap = true, desc = "sort lines" })
vim.keymap.set({ 'v', 'n' }, '<Leader>srn', ":sort n<cr>", { noremap = true, desc = "sort lines numerically" })
vim.keymap.set({ 'v', 'n' }, '<Leader>sru', ":sort u<cr>", { noremap = true, desc = "sort lines unique" })

-- Neovim Lua Helpers {{{1
vim.keymap.set('v', '<Leader>la', ':lua<CR>', { noremap = true, desc = "eval selection in nvim lua rt" })
vim.keymap.set("n", "<leader>la", "<cmd>.lua<CR>", { noremap = true, desc = "eval line in nvim lua rt" })
vim.keymap.set("n", "<leader><leader>la", "<cmd>source %<CR>", { noremap = true, desc = "eval buffer in nvim lua rt" })

-- Misc {{{1
vim.keymap.set('t', "<C-\\><C-\\>", "<C-\\><C-n>", { noremap = true, desc = "escape terminal mode" })
vim.keymap.set({ 'n', 'v' }, ',', ':', { noremap = true, desc = "enter <cmd> mode" })
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { noremap = true, desc = "no highlights" })
vim.keymap.set('n', '<Leader>h', '<cmd>noh<CR>', { noremap = true, desc = "no highlights" })
vim.keymap.set('n', '<Leader>rr', '<cmd>e!<CR>', { noremap = true, desc = "reload buffer from file on disk" })
vim.keymap.set('n', '<Leader>fs', '<cmd>w<CR>', { noremap = true, desc = "save file" })
vim.keymap.set('n', '<Leader>q', '<cmd>q<CR>', { noremap = true, desc = "quit neovim" })
vim.keymap.set('n', '<leader><leader>ex', ':r !sh<CR>')

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

vim.keymap.set(
  { "n" },
  "<leader>dt",
  function()
    vim.api.nvim_put({ " " .. vim.fn.system("date"):gsub("\n", "") }, "c", true, true)
  end,
  { noremap = true, desc = "insert unix current timestamp" }
)

-- vim:foldmethod=marker
