vim.opt.ruler         = false
vim.opt.tabstop       = 2
vim.opt.softtabstop   = 2
vim.opt.shiftwidth    = 2
vim.opt.smarttab      = true
vim.opt.expandtab     = true
vim.opt.backup        = false
vim.opt.clipboard     = 'unnamedplus'
vim.opt.winbar        = '%f'
vim.opt.number        = true
vim.opt.incsearch     = true
vim.opt.termguicolors = true
vim.opt.rnu           = true
vim.opt.mouse         = ''
vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.linebreak     = true
vim.opt.title         = true
vim.opt.showmatch     = true
vim.opt.hlsearch      = true
vim.opt.list          = false
vim.opt.lazyredraw    = true
vim.opt.cursorline    = true
vim.opt.inccommand    = 'nosplit'
vim.opt.autoindent    = true
vim.opt.updatetime    = 750
vim.opt.splitbelow    = true
vim.opt.splitright    = true
vim.opt.completeopt   = 'menuone,noinsert,noselect'
vim.opt.undofile      = false

vim.wo.signcolumn = 'number'
vim.wo.wrap       = true

vim.g.loaded                       = 1
vim.g.loaded_netrwPlugin           = 1
vim.g.mapleader                    = ';'
vim.g['user_emmet_expandabbr_key'] = '<C-a>,'
vim.g.loaded                       = 1
vim.g.loaded_netrwPlugin           = 1
vim.g.better_escape_shortcut       = 'jj'
vim.g.better_escape_interval       = 400

vim.api.nvim_set_hl(0, "CursorLine", { default = true, blend = 50 })
