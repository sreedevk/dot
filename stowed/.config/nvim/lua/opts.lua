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

vim.g.mapleader                        = ';'
vim.g['NERDTreeWinSize']               = 20
vim.g['NERDTreeAutoDeleteBuffer']      = 1
vim.g['NERDTreeMinimalUI']             = 1
vim.g['NERDTreeDirArrows']             = 1
vim.g['user_emmet_expandabbr_key']     = '<C-a>,'
vim.g['EasyMotion_smartcase']          = 1
vim.g['gundo_prefer_python3']          = 1
vim.g['ale_c_parse_makefile']          = 1
vim.g['ale_c_parse_makefile']          = 1
vim.g['githb_enterprise_urls']         = { 'https://github.tunecore.co' }
vim.g['coc_node_path']                 = "~/.asdf/shims/node"

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}')
vim.cmd('language en_US.utf-8')
vim.cmd('autocmd CursorHold * checktime')
vim.cmd('autocmd BufEnter *.heex :setlocal filetype=eelixir')
vim.cmd('autocmd BufNewFile,BufEnter *.org set ft=dotoo')


-- disable auto commenting
-- vim.cmd 'au BufEnter * set fo-=c fo-=r fo-=o'
