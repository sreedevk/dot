-- Resize Splits {{{1
vim.keymap.set("n", "<M-,>", "<c-w>5<", { noremap = true })
vim.keymap.set("n", "<M-.>", "<c-w>5>", { noremap = true })
vim.keymap.set("n", "<M-d>", "<C-W>+", { noremap = true })
vim.keymap.set("n", "<M-u>", "<C-W>-", { noremap = true })

-- Navigate Splits {{{1
vim.keymap.set("n", "<left>", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<right>", "<c-w>l", { noremap = true })
vim.keymap.set("n", "<down>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<up>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "]w", "<C-w>l", { noremap = true, desc = "Move to Window on Right" })
vim.keymap.set("n", "[w", "<C-w>h", { noremap = true, desc = "Move to Window on Left" })

-- Keep Center {{{1
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })

-- Tab Management {{{1
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>to', "<cmd>tabonly<cr>", { desc = "Delete All Other Tabs", noremap = true })
vim.keymap.set('n', '<Leader>ww', '<cmd>vnew<cr>', { desc = "New Vertical Window" })
vim.keymap.set('n', '<Leader>ws', '<cmd>new<cr>', { desc = "New Horizontal Window" })
vim.keymap.set('n', '<C-w>v', "<cmd>vnew<cr>", { desc = "New Vertical Window", noremap = true })
vim.keymap.set('n', '<C-w>s', "<cmd>new<cr>", { desc = "New Horizontal Window", noremap = true })

-- Buffer Navigation {{{1
vim.keymap.set('n', '<Leader>bb', '<cmd>bnext<CR>', { desc = "Buffer Next", noremap = true })
vim.keymap.set('n', '<Leader>bB', '<cmd>bprev<CR>', { desc = "Buffer Previous", noremap = true })
vim.keymap.set('n', '<M-[>', '<cmd>bprev<CR>', { desc = "Buffer Previous", noremap = true })
vim.keymap.set('n', '<M-]>', '<cmd>bnext<CR>', { desc = "Buffer Next", noremap = true })
vim.keymap.set('n', '<Leader>bD', wrap_cmd('w|%bd|e#'), { desc = "Delete Hidden Buffers", noremap = true })

vim.keymap.set('n', '<Leader>x', '<cmd>! chmod +x %<CR>', { desc = "Mark Current File Executable", noremap = true })
vim.keymap.set('n', '<leader>ssp', '<cmd>set spell!<CR>', { desc = "Enable Spell Check", noremap = true })

-- Sorting {{{1
vim.keymap.set('v', '<Leader>srr', "<cmd>sort<cr>", { desc = "Sort Numeric", noremap = true })
vim.keymap.set('v', '<Leader>srn', "<cmd>sort n<cr>", { desc = "Sort Numeric", noremap = true })
vim.keymap.set('v', '<Leader>sru', "<cmd>sort u<cr>", { desc = "Sort Uniq", noremap = true })

-- Neovim Lua Helpers {{{1
vim.keymap.set('v', '<Leader>la', ':lua<CR>', { desc = "Lua Execute Selection", noremap = true })
vim.keymap.set("n", "<leader>la", "<cmd>.lua<CR>", { desc = "Lua Execute Current Line", noremap = true })
vim.keymap.set("n", "<leader><leader>la", "<cmd>source %<CR>", { desc = "Lua Execute Buffer", noremap = true })

-- Misc {{{1
vim.keymap.set('t', "<C-\\><C-\\>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ 'n', 'v' }, ',', ':', { noremap = true })
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>h', '<cmd>noh<CR>', { desc = "No Highlight", noremap = true })
vim.keymap.set('n', '<Leader>rr', '<cmd>e!<CR>', { desc = "Reload File From Disk", noremap = true })
vim.keymap.set('n', '<Leader>fs', '<cmd>w<CR>', { desc = "File Save", noremap = true })
vim.keymap.set('n', '<Leader>q', '<cmd>q<CR>', { desc = "Quit Neovim", noremap = true })

vim.keymap.set(
  'n',
  '<Leader>vh',
  function() vim.cmd("h " .. vim.fn.expand('<cword>')) end,
  { desc = "Search help docs for cword", noremap = true }
)

vim.keymap.set(
  'n',
  '<Leader>cd',
  function() vim.cmd('tcd ' .. vim.fn.expand('%:p:h')) end,
  { desc = "CD Into Current Buffer Directory", noremap = true }
)

vim.keymap.set(
  "n",
  "<leader>dt",
  function() vim.api.nvim_put({ " " .. vim.fn.system("date"):gsub("\n", "") }, "c", true, true) end,
  { desc = "Insert TimeStamp" }
)

-- vim:foldmethod=marker
