local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Tree
map('n', '<C-n>', "<cmd>NeoTreeRevealToggle<CR>")
map('n', '<Leader>git', "<cmd>Neotree git_status<CR>")

-- convenience
map('n', '<Leader>w', "<cmd>w<CR>")
map('n', '<Leader>h', "<cmd>noh<CR>")

-- terminal
map('n', '<Leader>t', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>ft', "<cmd>ToggleTerm direction=float<CR>")

-- Hop
map('n', '<Leader>l', "<cmd>HopLine<CR>", {})
map('n', '<Leader>s', "<cmd>HopPattern<CR>", {})
map('n', '<Leader>f', "<cmd>HopChar1<CR>", {})

-- Telescope
map('n', '<C-p>', "<cmd>Telescope find_files<CR>")
map('n', '<C-b>', "<cmd>Telescope buffers<CR>")
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<Leader>fg', "<cmd>Telescope live_grep<CR>")
map('n', '<Leader>pp', ":lua require'telescope'.extensions.project.project{}<CR>")

-- Aerial
map('n', '<Leader>cv', "<cmd>AerialToggle<CR>")

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
map('v', '<Leader>p', '"_dP')

-- formatting
map('n', '<Leader>ff', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')
