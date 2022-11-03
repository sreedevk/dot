local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Tree
map('n', '<C-n>', "<cmd>NeoTreeRevealToggle<CR>")
map('n', '<Leader>t', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>w', "<cmd>w<CR>")
map('n', '<Leader>h', "<cmd>noh<CR>")

-- Hop
map('n', '<Leader>l', "<cmd>HopLine<CR>", {})
map('n', '<Leader>s', "<cmd>HopPattern<CR>", {})
map('n', '<Leader>f', "<cmd>HopChar1<CR>", {})

-- Telescope
map('n', '<C-p>', "<cmd>Telescope find_files<CR>")
map('n', '<C-b>', "<cmd>Telescope buffers<CR>")
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<leader>fg', "<cmd>Telescope live_grep<CR>")

-- Diff
map('n', '<Leader>gh', "<cmd>diffget //3<CR>")
map('n', '<Leader>gu', "<cmd>diffget //2<CR>")
map('n', '<Leader>gs', "<cmd>G<CR>")

-- Arrows
map('', '<up>', "<nop>")
map('', '<down>', "<nop>")
map('', '<left>', "<nop>")
map('', '<right>', "<nop>")

-- Tabs
map('n', '<C-t>', "<cmd>tabnew<CR>")

-- Easy Escape
map('t', 'jj', "<C-\\><C-n>")

-- Menu Nav
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- QuickFixList
map('n', '<C-k>', '<cmd>copen<CR>')
map('n', '<leader>p', '"_dP')

-- formatting
map('n', '<leader>ff', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')
