local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- inc/dev
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- lazy
map('n', '<Leader>lz', "<cmd>Lazy<CR>")

-- convenience
map('n', ',', ":")
map('v', ',', ":")
map('n', '<Leader>rr', "<cmd>e!<CR>")
map('n', '<Leader>fs', "<cmd>w<CR>")
map('n', '<Leader>sw', "<cmd>execute 'silent! write !sudo tee % >/dev/null' <bar> edit!<cr>")
map('n', '<Leader>q', "<cmd>q<CR>")
map('n', '<Leader>h', "<cmd>noh<CR>")
map("n", "<esc>", "<cmd>noh<cr>")
map('t', 'jj', "<C-\\><C-n>")
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<C-d>', "<C-d>zz")
map('n', '<C-u>', "<C-u>zz")
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")
map('n', '<Leader>x', "<cmd>! chmod +x %<CR>")
map("n", "<leader><leader>s", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>")

map('n', '<Leader>cd', "<cmd>lua vim.cmd('tcd ' .. vim.fn.expand('%:p:h'))<CR>")

-- Tabs
map('n', '<C-t>', "<cmd>tabnew<CR>")
map("n", "<Leader>ca", "<cmd>tabonly<cr>")

-- buffers
map('n', '<Leader>bb', '<cmd>bnext<CR>')
map('n', '<Leader>bB', '<cmd>bprev<CR>')

-- toggle
map('n', '<leader>sp', "<cmd>set spell!<CR>")

-- case conv
map('n', '<Leader>cml', [[:lua require("utils").convert_cword_to_camel()<CR>]])
map('n', '<Leader>snk', [[:lua require("utils").convert_cword_to_snake()<CR>]])

-- fetch url
map('n', '<Leader>fch', [[:lua require("utils").fetchjson()<CR>]])
