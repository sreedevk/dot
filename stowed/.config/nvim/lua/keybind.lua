local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Tree
map('n', '<Leader>git', "<cmd>Neotree git_status<CR>")
map('n', '<C-n>', "<cmd>NeoTreeRevealToggle<CR>")
map('n', '<Leader>gg', "<cmd>LazyGit<CR>")

-- convenience
map('n', '<Leader>w', "<cmd>w<CR>")
map('n', '<Leader>q', "<cmd>wqa<CR>")
map('n', '<Leader>h', "<cmd>noh<CR>")

-- terminal
map('n', '<Leader>t', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>")

-- Telescope
map('n', '<C-p>', "<cmd>Telescope find_files<CR>")
map('n', '<C-b>', "<cmd>Telescope buffers<CR>")
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<Leader>rg', "<cmd>Telescope live_grep<CR>")
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

-- Zen Mode
map('n', '<Leader>z', '<cmd>ZenMode<CR>')

-- Undo Tree
map('n', '<Leader>u', "<cmd>UndotreeToggle<CR>")

-- File Browser
map('n', '<Leader>fb', "<cmd>Telescope file_browser<CR>")

-- Easy Escape
map('t', '<Leader>jj', "<C-\\><C-n>")

-- Menu Nav
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('v', '<Leader>p', '"_dP')

-- lsp
map('n', '<Leader>ff', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')
map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>')

