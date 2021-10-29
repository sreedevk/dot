local opt = vim.opt -- to set options
local g   = vim.g   -- a table to access global variables

opt.expandtab     = true
opt.tabstop       = 2
opt.shiftwidth    = 2
opt.clipboard     = 'unnamedplus'
opt.number        = true
opt.expandtab     = true
opt.autoread      = true
opt.incsearch     = true
opt.termguicolors = true
opt.rnu           = true               -- relative line number
opt.ignorecase    = true               -- ignore case while searching
opt.linebreak     = true               -- avoid breaking words while wrapping lines
opt.title         = true               -- show window title as current file name
opt.showmatch     = true               -- enable highlighing matching paranthesis
opt.hlsearch      = true               -- enable search highlights
opt.t_Co          = 256
opt.list          = false              -- show trailing whitespaces
opt.lazyredraw    = false              -- only redraw window when required
opt.cursorline    = true               -- highlight line under cusor
opt.inccommand    = 'nosplit'          -- shows search and replace changes live
opt.updatetime    = 750
opt.splitbelow    = true               -- Put new windows below current
opt.splitright    = true               -- Put new windows right of current

g['NERDTreeWinSize']               = 20
g['NERDTreeAutoDeleteBuffer']      = 1
g['NERDTreeMinimalUI']             = 1
g['NERDTreeDirArrows']             = 1
g['user_emmet_expandabbr_key']     = '<C-a>,'
g['EasyMotion_smartcase']          = 1
g['gundo_prefer_python3']          = 1
g['ale_c_parse_makefile']          = 1
g['mapleader']                     = ';'

