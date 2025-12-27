vim.g.mapleader         = ';'

vim.g.auxbuffers        = {
  "qf",
  "help",
  "man",
  "notify",
  "nofile",
  "lspinfo",
  "terminal",
  "prompt",
  "toggleterm",
  "startuptime",
  "tsplayground",
  "PlenaryTestPopup",
  "trouble",
  "vim",
  "undotree",
  "neo-tree",
  'gitcommit',
  'gitrebase'
}

vim.g.loaded            = 1
vim.g.loaded_matchparen = 0
vim.g.termdebugger      = "rust-gdb"
vim.g.dotfiles          = vim.env.DOTFILES or vim.fn.expand('~/.dot')

vim.opt.ruler           = true
vim.opt.tabstop         = 2
vim.opt.softtabstop     = 2
vim.opt.shiftwidth      = 2
vim.opt.smarttab        = true
vim.opt.expandtab       = true
vim.opt.clipboard       = { 'unnamedplus' }
vim.opt.breakat         = [[\ \	;:,!?]]
vim.opt.breakindentopt  = "shift:2,min:20"
vim.opt.winbar          = '%f'
vim.opt.cmdheight       = 0
vim.opt.cmdwinheight    = 5
vim.opt.incsearch       = true
vim.opt.infercase       = true
vim.opt.termguicolors   = true
vim.opt.jumpoptions     = { "stack" }
vim.opt.rnu             = true
vim.opt.number          = true
vim.opt.ignorecase      = true
vim.opt.smartcase       = true
vim.opt.wrapscan        = true
vim.opt.smartindent     = true
vim.opt.linebreak       = true
vim.opt.breakindent     = true
vim.opt.title           = true
vim.opt.signcolumn      = 'yes'
vim.opt.showmatch       = true
vim.opt.hlsearch        = true
vim.opt.list            = false
vim.opt.lazyredraw      = false
vim.opt.cursorcolumn    = false
vim.opt.cursorline      = true
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
vim.opt.concealcursor   = "niv"
vim.opt.conceallevel    = 0
vim.opt.foldenable      = false
vim.opt.foldmethod      = 'manual'
vim.opt.virtualedit     = 'block'
vim.opt.pumblend        = 10
vim.opt.pumheight       = 15
vim.opt.winblend        = 10
vim.opt.scrolloff       = 10
vim.opt.sidescrolloff   = 10
vim.opt.sidescroll      = 1
vim.opt.confirm         = true
vim.opt.emoji           = false

vim.opt.showcmd         = true
vim.opt.showcmdloc      = "statusline"
vim.opt.showtabline     = 1
vim.opt.splitright      = true
vim.opt.synmaxcol       = 500
vim.opt.laststatus      = 3
vim.opt.timeoutlen      = 500
vim.opt.ttimeoutlen     = 10
vim.opt.switchbuf       = 'useopen,uselast'
vim.opt.grepprg         = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
vim.opt.grepformat      = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
vim.opt.showbreak       = [[… ]] -- Options include -> '↪', '↳ ', '→','↳ '
vim.opt.wrap            = true
vim.opt.wrapmargin      = 2
vim.opt.cursorlineopt   = { 'both' }
vim.opt.matchpairs      = { "(:)", "{:}", "[:]", "<:>" }

vim.opt.mouse           = 'a'
vim.opt.mousefocus      = true
vim.opt.mousescroll     = { 'ver:1', 'hor:6' }

vim.opt.backup          = false
vim.opt.writebackup     = false
vim.opt.swapfile        = false
vim.opt.undofile        = false

vim.opt.guicursor       = {
  'n-v-c-sm:block-Cursor',
  'i-ci-ve:ver25-iCursor',
  'r-cr-o:hor20-Cursor',
  'a:blinkon0',
}

vim.opt.sessionoptions  = {
  'buffers',
  'curdir',
  'folds',
}

vim.opt.completeopt     = {
  'menuone',  -- show menu even if there's only one item
  'noinsert', -- no insertions until user selects
  'noselect', -- no preselection
  'fuzzy'     -- enable fuzzy matching
}

vim.opt.fillchars       = {
  eob       = ' ',
  diff      = '⣿',
  msgsep    = '─',
  fold      = ' ',
  foldopen  = '▼',
  foldclose = '▶',
  foldsep   = ' ',
}

vim.opt.listchars       = {
  eol      = nil,
  tab      = '▷▷',
  extends  = '»',
  precedes = '«',
  trail    = '•',
}

vim.opt.diffopt         = vim.opt.diffopt
    + {
      'vertical',
      'filler',
      'iwhite',
      'hiddenoff',
      'foldcolumn:0',
      'context:4',
      'algorithm:histogram',
      'indent-heuristic',
      'linematch:60',
    }

vim.opt.shortmess       = {
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

vim.opt.formatoptions   = {
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  q = true,     -- continue comments with gq"
  c = true,     -- Auto-wrap comments using textwidth
  r = true,     -- Continue comments when pressing Enter
  n = true,     -- Recognize numbered lists
  t = false,    -- autowrap lines using text width value
  j = true,     -- remove a comment leader when joining lines.
  l = true,
  v = true,
}

vim.opt.spellsuggest:prepend({ 12 })
vim.opt.spelloptions:append({ 'camel', 'noplainbuffer' })
vim.opt.spellcapcheck = ''
vim.opt.spellfile = vim.fn.expand(vim.g.dotfiles .. "/stowed/.config/nvim/spell/en.utf-8.add")

vim.api.nvim_set_hl(0, "CursorLine", { default = true, blend = 50 })
