local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn  = vim.fn  -- to call vim functions e.g. fn.bufnr()
local g   = vim.g   -- a table to access global variables
local opt = vim.opt -- to set options

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'dense-analysis/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'easymotion/vim-easymotion' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'mattn/emmet-vim' }
  use { 'scrooloose/syntastic' } 
  use { 'scrooloose/nerdTree' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'sheerun/vim-polyglot' }
  use { 'sjl/gundo.vim' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rails' }
  use { 'hoob3rt/lualine.nvim' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-surround' }
  use { 'bollu/vim-apl' }
  use { 'ayu-theme/ayu-vim' }
  use { 'cseelus/vim-colors-lucid' }
  use {'dracula/vim', as = 'dracula' }
  use { 'neovim/nvim-lspconfig' }
end)

g['NERDTreeWinSize']               = 20
g['NERDTreeAutoDeleteBuffer']      = 1
g['NERDTreeMinimalUI']             = 1
g['NERDTreeDirArrows']             = 1
g['user_emmet_expandabbr_key']     = '<C-a>,'
g['syntastic_typescript_checkers'] = ['tsuquyomi', 'tslint --type-check']
g['EasyMotion_smartcase']          = 1
g['gundo_prefer_python3']          = 1
g['github_enterprise_urls']        = ['https://github.tunecore.co']
g['ale_c_parse_makefile']          = 1
g['mapleader']                     = ';'

cmd 'colorscheme ayu' 

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
