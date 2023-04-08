local map = require('helpers').map

-- git
map('n', '<Leader>gi', "<cmd>Git<CR>")
map('n', '<Leader>gs', "<cmd>Neotree git_status<CR>")
map('n', '<Leader>glg', "<cmd>Git log --oneline --decorate --graph<CR>")
map('n', '<Leader>glo', "<cmd>Git log<CR>")
map('n', '<Leader>gpu', "<cmd>Git push<CR>")
map('n', '<Leader>gpl', "<cmd>Git pull<CR>")

-- inc/dev
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- lazy
map('n', '<Leader>l', "<cmd>Lazy<CR>")

-- convenience
map('n', '<Leader>w', "<cmd>w<CR>")
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

-- Neotree
map('n', '<C-n>', "<cmd>Neotree reveal toggle<CR>")

-- File/Dir Nav
map('n', '<Leader>cd', "<cmd>lua vim.cmd('cd ' .. vim.fn.expand('%:p:h'))<CR>")
map('n', '<C-p>', "<cmd>Telescope find_files<CR>")
map('n', '<Leader>fb', "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
map('n', '<Leader>rg', "<cmd>Telescope live_grep<CR>")

-- telescope
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<Leader>gr', "<cmd>Telescope grep_string<CR>")

-- LSP/TS
map('n', '<Leader>cv', "<cmd>Lspsaga outline<CR>")

-- chadmode: no arrow keys
map('', '<up>', "<nop>")
map('', '<down>', "<nop>")
map('', '<left>', "<nop>")
map('', '<right>', "<nop>")
map("n", "Q", "<nop>")

-- Tabs
map('n', '<C-t>', "<cmd>tabnew<CR>")
map("n", "<Leader>ca", "<cmd>tabonly<cr>")

-- buffers
map('n', '<Leader>bl', "<cmd>Telescope buffers<CR>")
map('n', '<Leader>bd', "<cmd>bd<CR>")
map('n', '<Leader>bb', '<cmd>bnext<CR>')
map('n', '<Leader>bB', '<cmd>bprev<CR>')

-- toggle
map('n', '<Leader>tm', "<cmd>TableModeToggle<CR>")
map('n', '<leader>tv', "<cmd>ToggleVenn<CR>")
map('n', '<leader>ts', "<cmd>set spell!<CR>")
map('n', '<Leader>tu', "<cmd>UndotreeToggle<CR>")
map('n', '<Leader>tr', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>")
map('n', '<Leader>tz', '<cmd>ZenMode<CR>')
map('n', '<Leader>tdq', '<cmd>TroubleToggle quickfix<CR>')

-- alt toggle
map('n', '<Leader>z', '<cmd>ZenMode<CR>')
map('n', '<Leader>u', "<cmd>UndotreeToggle<CR>")

-- Run Command
map('n', '<Leader>rn', '<cmd>CmdRun<CR>')
map('v', '<Leader>rs', ":'>ToggleTermSendVisualLine<CR>")

-- debugging
map('n', '<F5>', ':lua require("dap").continue()<CR>')
map('n', '<F10>', ':lua require("dap").step_over()<CR>')
map('n', '<F11>', ':lua require("dap").step_into()<CR>')
map('n', '<F12>', ':lua require("dap").step_out()<CR>')
map('n', '<Leader>dB', ':lua require("dap").toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))<CR>')
map('n', '<Leader>dbp', ':lua require("dap").toggle_breakpoint()<CR>')
map('n', '<Leader>dlp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("log point message: "))<CR>')
map('n', '<Leader>drp', ':lua require("dap").repl.open()<CR>')
map('n', '<Leader>duo', ':lua require("dapui").open()<CR>')
map('n', '<Leader>duc', ':lua require("dapui").close()<CR>')
