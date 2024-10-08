local map = require('helpers').map

-- git
map("n", "<Leader>gi", "<cmd>Neogit<CR>")

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

-- diffview
map('n', '<Leader>dvo', "<cmd>DiffviewOpen<CR>")
map('n', '<Leader>dvc', "<cmd>DiffviewClose<CR>")

-- Neotree
map('n', '<C-n>', "<cmd>Neotree filesystem toggle<CR>")

-- telescope
map('n', '<Leader>cd', "<cmd>lua vim.cmd('cd ' .. vim.fn.expand('%:p:h'))<CR>")
map('n', '<C-p>', "<cmd>Telescope find_files<CR>")
map('n', '<Leader>p', "<cmd>Telescope git_files<CR>")
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<leader>fw', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>")
map('n', '<Leader>rg', "<cmd>Telescope live_grep<CR>")

-- lspsaga
map('n', '<Leader>cv', "<cmd>Lspsaga outline<CR>")

-- Tabs
map('n', '<C-t>', "<cmd>tabnew<CR>")
map("n", "<Leader>ca", "<cmd>tabonly<cr>")

-- buffers
map('n', '<Leader>bl', "<cmd>Telescope buffers<CR>")
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
