local map = require('helpers').map

-- git
map('n', '<Leader>gi', "<cmd>Git<CR>")
map('n', '<Leader>gs', "<cmd>Neotree git_status<CR>")
map('n', '<Leader>glg', "<cmd>Git log --oneline --decorate --graph<CR>")
map('n', '<Leader>glo', "<cmd>Git log<CR>")

-- lazy
map('n', '<Leader>lz', "<cmd>Lazy<CR>")

-- convenience
map('n', '<Leader>w', "<cmd>w<CR>")
map('n', '<Leader>q', "<cmd>q<CR>")
map('n', '<Leader>h', "<cmd>noh<CR>")
map('n', '<C-n>', "<cmd>Neotree reveal toggle<CR>")

-- terminal
map('n', '<Leader>tr', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>")

-- telescope
map('n', '<C-p>', "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>")
map('n', '<Leader>fb', "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
map('n', '<Leader>bl', "<cmd>Telescope buffers<CR>")
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<Leader>rg', "<cmd>Telescope live_grep<CR>")
map('n', '<Leader>gr', "<cmd>Telescope grep_string<CR>")

-- aerial
map('n', '<Leader>cv', "<cmd>Lspsaga outline<CR>")

-- disable arrows
map('', '<up>', "<nop>")
map('', '<down>', "<nop>")
map('', '<left>', "<nop>")
map('', '<right>', "<nop>")

-- tab nav
map('n', '<C-t>', "<cmd>tabnew<CR>")

-- zen mode 
map('n', '<Leader>z', '<cmd>ZenMode<CR>')

-- undo tree
map('n', '<Leader>u', "<cmd>UndotreeToggle<CR>")

-- easy escape
map('t', '<Leader>jj', "<C-\\><C-n>")

-- search nav
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- buffer nav
map('n', '<C-d>', "<C-d>zz")
map('n', '<C-u>', "<C-u>zz")

-- buffer switch
map('n', '<Leader>bb', '<cmd>bnext<CR>')
map('n', '<Leader>bB', '<cmd>bprev<CR>')

-- notes
map('n', '<Leader>no', "<cmd>Neorg index<CR>")
map('n', '<Leader>nr', "<cmd>Neorg return<CR>")
map('n', '<Leader>nj', "<cmd>Neorg journal<CR>")
map('n', '<Leader>tm', "<cmd>TableModeToggle<CR>")
map('n', '<leader>ve', ":lua require('helpers').toggle_venn()<CR>")

-- Move
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")

-- Utils
map('n', '<Leader>x', "<cmd>! chmod +x %<CR>")

-- spell check
map('n', '<Leader>sk', '<cmd>spell!<CR>')
