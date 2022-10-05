vim.opt.ruler         = false
vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2
vim.opt.expandtab     = true
vim.opt.clipboard     = 'unnamedplus'
vim.opt.winbar        = '%f'
vim.opt.number        = true
vim.opt.incsearch     = true
vim.opt.termguicolors = true
vim.opt.rnu           = true               -- relative line number
vim.opt.ignorecase    = true               -- ignore case while searching
vim.opt.linebreak     = true               -- avoid breaking words while wrapping lines
vim.opt.title         = true               -- show window title as current file name
vim.opt.showmatch     = true               -- enable highlighing matching paranthesis
vim.opt.hlsearch      = true               -- enable search highlights
vim.opt.list          = false              -- show trailing whitespaces
vim.opt.lazyredraw    = true               -- only redraw window when required
vim.opt.cursorline    = true               -- highlight line under cusor
vim.opt.inccommand    = 'nosplit'          -- shows search and replace changes live
vim.opt.autoindent    = true
vim.opt.updatetime    = 750
vim.opt.splitbelow    = true               -- Put new windows below current
vim.opt.splitright    = true               -- Put new windows right of current
vim.opt.completeopt   = 'menuone,noinsert,noselect'

vim.wo.signcolumn = 'number'
vim.wo.wrap       = true

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader                        = ';'
vim.g['user_emmet_expandabbr_key']     = '<C-a>,'
vim.g['gundo_prefer_python3']          = 1
vim.g['ale_c_parse_makefile']          = 1
vim.g['ale_c_parse_makefile']          = 1
vim.g['coc_node_path']                 = "~/.asdf/shims/node"
vim.g.polyglot_disabled                = { "autoindent", "sensible" }
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}')
vim.cmd('language en_US.utf-8')
vim.cmd('autocmd CursorHold * checktime')
vim.cmd('autocmd BufEnter *.heex :setlocal filetype=eelixir')

-- disable auto commenting
-- vim.cmd 'au BufEnter * set fo-=c fo-=r fo-=o'
