"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄  
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█  
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄ 
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒   
"      ░░   ▒ ░░      ░     ░░   ░ ░        
"       ░   ░         ░      ░     ░ ░      
"      ░                           ░        
" AUTHOR: SREEDEV KODICHATH

set runtimepath+=~/.vim,~/.vim/after
" set packpath+=~/.vim
" source ~/.vimrc

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-ragtag'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdTree'
Plug 'easymotion/vim-easymotion'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
Plug 'srcery-colors/srcery-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mileszs/ack.vim'
Plug 'jceb/vim-orgmode'

call plug#end()

filetype plugin indent on    " required
syntax on
colorscheme ayu

set tabstop=2
set shiftwidth=2
set clipboard=unnamedplus
set number
set expandtab
set incsearch
set termguicolors
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set rnu
set ignorecase
set linebreak
set title " show window title as current file name
set showmatch " enable highlighing matching paranthesis
set hlsearch " enable search highlights
set list " show trailing whitespaces

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

let mapleader = ";"
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:user_emmet_expandabbr_key = '<C-a>,'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:deoplete#enable_at_startup = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 0 
let g:NERDTreeWinSize=20
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint --type-check']
let g:syntastic_typescript_tslint_args = "--config ~/.config/nvim/add_conf/tslint.json"
let g:EasyMotion_smartcase = 1
" let g:airline#extensions#tabline#enabled = 1

map <Leader> <Plug>(easymotion-prefix)

nmap <C-n> :NERDTreeToggle<CR>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <C-t> :tabnew <CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR> 
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>h :noh<CR>

silent! call airline#extensions#whitespace#disable()

inoremap jj <ESC>
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

tnoremap jj <C-\><C-n>

command! -complete=file -nargs=1 T tabedit <args>
command! NT NERDTree
command! W w
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
