local utils = require("core.utils")

vim.keymap.set("n", "<M-,>", "<c-w>5<", { noremap = true })
vim.keymap.set("n", "<M-.>", "<c-w>5>", { noremap = true })
vim.keymap.set("n", "<M-d>", "<C-W>+", { noremap = true })
vim.keymap.set("n", "<M-u>", "<C-W>-", { noremap = true })

vim.keymap.set("n", "<left>", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<right>", "<c-w>l", { noremap = true })
vim.keymap.set("n", "<down>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<up>", "<C-w>-k", { noremap = true })

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('t', "<C-\\><C-\\>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ 'n', 'v' }, ',', ':', { noremap = true })
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>', { noremap = true })
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { noremap = true })

vim.keymap.set('n', '<Leader>bb', '<cmd>bnext<CR>', { desc = "Buffer Next", noremap = true })
vim.keymap.set('n', '<Leader>bB', '<cmd>bprev<CR>', { desc = "Buffer Previous", noremap = true })
vim.keymap.set("n", "<leader><leader>la", "<cmd>source %<CR>", { desc = "Lua Execute Buffer", noremap = true })

vim.keymap.set('n', '<Leader>ww', '<cmd>vnew<cr>', { desc = "New Vertical Window" })
vim.keymap.set('n', '<Leader>ws', '<cmd>new<cr>', { desc = "New Horizontal Window" })
vim.keymap.set('n', '<C-w>v', "<cmd>vnew<cr>", { desc = "New Vertical Window", noremap = true })
vim.keymap.set('n', '<C-w>s', "<cmd>new<cr>", { desc = "New Horizontal Window", noremap = true })

vim.keymap.set('n', '<Leader>lz', '<cmd>Lazy<CR>', { desc = "Lazy Dashboard", noremap = true })
vim.keymap.set('n', '<Leader>rr', '<cmd>e!<CR>', { desc = "Reload File From Disk", noremap = true })
vim.keymap.set('n', '<Leader>fs', '<cmd>w<CR>', { desc = "File Save", noremap = true })
vim.keymap.set('n', '<Leader>q', '<cmd>q<CR>', { desc = "Quit Neovim", noremap = true })
vim.keymap.set('n', '<Leader>h', '<cmd>noh<CR>', { desc = "No Highlight", noremap = true })
vim.keymap.set('n', '<Leader>x', '<cmd>! chmod +x %<CR>', { desc = "Mark Current File Executable", noremap = true })
vim.keymap.set('n', '<Leader>to', "<cmd>tabonly<cr>", { desc = "Delete All Other Tabs", noremap = true })
vim.keymap.set('n', '<leader>ssp', '<cmd>set spell!<CR>', { desc = "Enable Spell Check", noremap = true })
vim.keymap.set('v', '<Leader>la', ':lua<CR>', { desc = "Lua Execute Selection", noremap = true })
vim.keymap.set("n", "<leader>la", "<cmd>.lua<CR>", { desc = "Lua Execute Current Line", noremap = true })
vim.keymap.set('v', '<Leader>srr', "<cmd>sort<cr>", { desc = "Sort Numeric", noremap = true })
vim.keymap.set('v', '<Leader>srn', "<cmd>sort n<cr>", { desc = "Sort Numeric", noremap = true })
vim.keymap.set('v', '<Leader>sru', "<cmd>sort u<cr>", { desc = "Sort Uniq", noremap = true })

vim.keymap.set('n', '<Leader>cml', utils.convert_cword_to_camel, { desc = "Camelize cword", noremap = true })
vim.keymap.set('n', '<Leader>snk', utils.convert_cword_to_snake, { desc = "Snakeize cword", noremap = true })

vim.keymap.set(
  'n',
  '<Leader>sw',
  "<cmd>execute 'silent! write !sudo tee % >/dev/null' <bar> edit!<cr>",
  { desc = "Sudo Write!", noremap = true }
)

vim.keymap.set(
  'n',
  '<leader><leader>s',
  ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>",
  { desc = "Find & Replace", noremap = true }
)

vim.keymap.set(
  'n',
  '<Leader>cd',
  function()
    vim.cmd('tcd ' .. vim.fn.expand('%:p:h'))
  end,
  { desc = "CD Into Current Buffer Directory", noremap = true }
)

vim.keymap.set(
  "n",
  "<leader>dt",
  function()
    local date = vim.fn.system("date"):gsub("\n", "")
    vim.api.nvim_put({ " " .. date }, "c", true, true)
  end,
  { desc = "Insert TimeStamp" }
)
