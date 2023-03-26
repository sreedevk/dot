vim.opt.ruler                = false
vim.opt.tabstop              = 2
vim.opt.softtabstop          = 2
vim.opt.shiftwidth           = 2
vim.opt.smarttab             = true
vim.opt.expandtab            = true
vim.opt.backup               = false
vim.opt.writebackup          = false
vim.opt.clipboard            = 'unnamedplus'
vim.opt.winbar               = '%f'
vim.opt.number               = true
vim.opt.incsearch            = true
vim.opt.infercase            = true
vim.opt.termguicolors        = true
vim.opt.rnu                  = true
vim.opt.mouse                = ''
vim.opt.ignorecase           = true
vim.opt.smartcase            = true
vim.opt.smartindent          = true
vim.opt.linebreak            = true
vim.opt.breakindent          = true
vim.opt.title                = true
vim.opt.showmatch            = true
vim.opt.hlsearch             = true
vim.opt.list                 = false
vim.opt.lazyredraw           = true
vim.opt.cursorcolumn         = false
vim.opt.cursorline           = true
vim.opt.inccommand           = 'nosplit'
vim.opt.autoindent           = true
vim.opt.updatetime           = 750
vim.opt.splitbelow           = true
vim.opt.splitright           = true
vim.opt.completeopt          = 'menuone,noinsert,noselect'
vim.opt.undofile             = false
vim.opt.foldmethod           = "expr"
vim.opt.foldexpr             = "nvim_treesitter#foldexpr()"
vim.opt.foldenable           = false
vim.opt.virtualedit          = 'block'
vim.opt.pumblend             = 10
vim.opt.pumheight            = 10
vim.opt.winblend             = 10
vim.opt.listchars            = 'extends:…,precedes:…,nbsp:␣'
vim.opt.scrolloff            = 10
vim.opt.conceallevel         = 2
vim.opt.concealcursor        = 'nc'

vim.wo.signcolumn            = 'number'
vim.wo.wrap                  = true

vim.g.loaded                 = 1
vim.g.loaded_netrwPlugin     = 1
vim.g.mapleader              = ';'
vim.g.loaded                 = 1
vim.g.loaded_netrwPlugin     = 1
vim.g.better_escape_shortcut = 'jj'
vim.g.better_escape_interval = 400
vim.g.user_emmet_leader_key  = "<C-a>"
vim.api.nvim_set_hl(0, "CursorLine", { default = true, blend = 50 })
