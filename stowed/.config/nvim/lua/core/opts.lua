vim.g.loaded            = 1
vim.g.loaded_matchparen = 0
vim.g.mapleader         = ';'
vim.g.termdebugger      = "rust-gdb"

vim.opt.ruler           = true
vim.opt.tabstop         = 2
vim.opt.softtabstop     = 2
vim.opt.shiftwidth      = 2
vim.opt.smarttab        = true
vim.opt.expandtab       = true
vim.opt.clipboard       = 'unnamedplus'
vim.opt.breakat         = [[\ \	;:,!?]]
vim.opt.breakindentopt  = "shift:2,min:20"
vim.opt.winbar          = '%f'
vim.opt.cmdheight       = 0
vim.opt.cmdwinheight    = 5
vim.opt.incsearch       = true
vim.opt.infercase       = true
vim.opt.termguicolors   = true
vim.opt.jumpoptions     = "stack"
vim.opt.rnu             = true
vim.opt.number          = true
vim.opt.mouse           = 'a'
vim.opt.ignorecase      = true
vim.opt.smartcase       = true
vim.opt.smartindent     = true
vim.opt.linebreak       = true
vim.opt.breakindent     = true
vim.opt.title           = true
vim.opt.showmatch       = true
vim.opt.hlsearch        = true
vim.opt.list            = false
vim.opt.matchpairs      = { "(:)", "{:}", "[:]", "<:>" }
vim.opt.lazyredraw      = true
vim.opt.cursorcolumn    = false
vim.opt.cursorline      = true
vim.opt.diffopt         = "filler,iwhite,internal,algorithm:patience"
vim.opt.inccommand      = 'split'
vim.opt.splitbelow      = true
vim.opt.splitright      = true
vim.opt.encoding        = "utf-8"
vim.opt.autoread        = true
vim.opt.backspace       = "indent,eol,start"
vim.opt.helpheight      = 12
vim.opt.autoindent      = true
vim.opt.updatetime      = 500
vim.opt.splitbelow      = true
vim.opt.splitright      = true
vim.opt.completeopt     = 'menuone,noinsert,noselect'
vim.opt.concealcursor   = "niv"
vim.opt.conceallevel    = 0
vim.opt.undofile        = false
vim.opt.foldenable      = false
vim.opt.foldmethod      = 'manual'
vim.opt.virtualedit     = 'block'
vim.opt.pumblend        = 10
vim.opt.pumheight       = 10
vim.opt.winblend        = 10
vim.opt.listchars       = 'extends:…,precedes:…,nbsp:␣'
vim.opt.scrolloff       = 10

vim.opt.showcmd         = true
vim.opt.showcmdloc      = "statusline"
vim.opt.showtabline     = 1
vim.opt.splitright      = true
vim.opt.synmaxcol       = 500
vim.opt.laststatus      = 3
vim.opt.swapfile        = false
vim.opt.backup          = false
vim.opt.writebackup     = false

vim.opt.formatoptions:remove "o"

vim.opt.shortmess = {
  A = true, -- ignore annoying swap file messages
  F = true, -- Don't give file info when editing a file
  I = true, -- don't give the intro message when starting Vim
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  W = true, -- Don't show [w] or written when writing
  a = true, -- lmrw abbreviations
  c = true,
  o = true, -- file-read message overwrites previous
  r = true, -- use "[RO]" instead of "[readonly]"
  s = true, -- don't give "search hit BOTTOM, continuing at TOP"
  t = true, -- truncate file messages at start
}
vim.wo.wrap       = true

vim.api.nvim_set_hl(0, "CursorLine", { default = true, blend = 50 })

