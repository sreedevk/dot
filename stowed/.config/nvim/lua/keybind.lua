local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Tree
map('n', '<Leader>gi', "<cmd>Git<CR>")
map('n', '<Leader>gs', "<cmd>Neotree git_status<CR>")
map('n', '<Leader>glg', "<cmd>Git log --oneline --decorate --graph<CR>")
map('n', '<Leader>glo', "<cmd>Git log<CR>")

-- Lazy
map('n', '<Leader>lz', "<cmd>Lazy<CR>")

-- convenience
map('n', '<Leader>w', "<cmd>w<CR>")
map('n', '<Leader>q', "<cmd>q<CR>")
map('n', '<Leader>h', "<cmd>noh<CR>")
map('n', '<C-n>', "<cmd>Neotree reveal toggle<CR>")

-- terminal
map('n', '<Leader>tr', "<cmd>ToggleTerm<CR>")
map('n', '<Leader>tf', "<cmd>ToggleTerm direction=float<CR>")

-- Telescope
map('n', '<C-p>', "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>")
map('n', '<Leader>fb', "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
map('n', '<Leader>bl', "<cmd>Telescope buffers<CR>")
map('n', '<C-s>', "<cmd>Telescope<CR>")
map('n', '<Leader>rg', "<cmd>Telescope live_grep<CR>")
map('n', '<Leader>gr', "<cmd>Telescope grep_string<CR>")
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

-- Easy Escape
map('t', '<Leader>jj', "<C-\\><C-n>")

-- Menu Nav
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Easy Buffer Nav
map('n', '<Leader>bb', '<cmd>bnext<CR>')
map('n', '<Leader>bB', '<cmd>bprev<CR>')

-- Notes
map('n', '<Leader>no', "<cmd>Neorg index<CR>")
map('n', '<Leader>nr', "<cmd>Neorg return<CR>")
map('n', '<Leader>nj', "<cmd>Neorg journal<CR>")
map('n', '<Leader>tm', "<cmd>TableModeToggle<CR>")

-- Venn
map('n', '<leader>v', ":lua require('helpers').toggle_venn()<CR>")

-- Move
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")
