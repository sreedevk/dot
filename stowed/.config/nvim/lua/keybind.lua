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

map('n', '<Leader>cd', "<cmd>lua vim.cmd('cd ' .. vim.fn.expand('%:p:h'))<CR>")

-- lspsaga
map('n', '<Leader>cv', "<cmd>Lspsaga outline<CR>")

-- Tabs
map('n', '<C-t>', "<cmd>tabnew<CR>")
map("n", "<Leader>ca", "<cmd>tabonly<cr>")

-- buffers
map('n', '<Leader>bd', "<cmd>Bdelete<CR>")
map('n', '<Leader>bb', '<cmd>bnext<CR>')
map('n', '<Leader>bB', '<cmd>bprev<CR>')

-- toggle
map('n', '<Leader>tm', "<cmd>TableModeToggle<CR>")
map('n', '<leader>ts', "<cmd>set spell!<CR>")
map('n', '<Leader>tr', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>")
map('n', '<Leader>tz', '<cmd>ZenMode<CR>')
map('n', '<Leader>tt', '<cmd>TroubleToggle quickfix<CR>')

-- alt toggle
map('n', '<Leader>u', "<cmd>UndotreeToggle<CR>")

-- Run Command
map('v', '<Leader>rs', ":'>ToggleTermSendVisualLine<CR>")

-- persistence
map('n', '<leader>sp', [[<cmd>lua require("persistence").load({last=true})<cr>]])
map("n", "<leader>so", [[<cmd>lua require("persistence").load()<cr>]])
map("n", "<leader>sd", [[<cmd>lua require("persistence").stop()<cr>]])

-- leader
map("n", "<leader>j", [[<cmd>TSJToggle<cr>]])

-- zoxide
map('n', '<Leader>zi', [[<cmd>Zi<cr>]])
map('n', '<Leader>zz', ':Z ')

-- case conv
map('n', '<Leader>cml', [[:lua require("utils").convert_cword_to_camel()<CR>]])
map('n', '<Leader>snk', [[:lua require("utils").convert_cword_to_snake()<CR>]])

-- fetch url
map('n', '<Leader>fch', [[:lua require("utils").fetchjson()<CR>]])
