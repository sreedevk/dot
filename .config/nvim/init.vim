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

" set packpath+=~/.vim
" source ~/.vimrc

set runtimepath+=~/.vim,~/.vim/after
source ~/.config/nvim/plug-config/coc.vim

call plug#begin('~/.vim/nvim/plugged')
  Plug 'dense-analysis/ale'
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/fzf.vim'
  Plug 'mattn/emmet-vim'
  Plug 'scrooloose/syntastic'
  Plug 'scrooloose/nerdTree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'sjl/gundo.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-surround'
  Plug 'bollu/vim-apl'
  Plug 'ayu-theme/ayu-vim'
call plug#end()

filetype plugin indent on    " required
syntax on

set tabstop=2
set shiftwidth=2
set clipboard=unnamedplus
set number
set expandtab
set autoread
set incsearch
set termguicolors
set rnu " relative number option
set ignorecase " ignore case while searching
set linebreak " avoid breaking words while wrapping lines
set title " show window title as current file name
set showmatch " enable highlighing matching paranthesis
set hlsearch " enable search highlights
set t_Co=256
" set list " show trailing whitespaces
" set lazyredraw " only redraw window when required
set cursorline " highlight line under cusor
set inccommand=nosplit " shows search and replace changes live
set updatetime=750

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
autocmd CursorHold * checktime

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize=20

let g:user_emmet_expandabbr_key = '<C-a>,'
let g:deoplete#enable_at_startup = 1

let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint --type-check']
let g:syntastic_typescript_tslint_args = "--config ~/.config/nvim/add_conf/tslint.json"

let g:EasyMotion_smartcase = 1
let g:gundo_prefer_python3 = 1
let g:github_enterprise_urls = ['https://github.tunecore.co']
let g:ale_c_parse_makefile = 1

" let ayucolor="light"
" let ayucolor="mirage"
let ayucolor="dark"

map <Leader> <Plug>(easymotion-prefix)

nmap <C-n> :NERDTreeToggle<CR>
nmap <C-p> :FZF<CR>

nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

cmap <C-R>'           <C-R>=shellescape(getline('.'))<CR>
cmap <C-R><C-R>' <C-R><C-R>=shellescape(getline('.'))<CR>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <C-t> :tabnew <CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR> 
nnoremap <C-b> :Buffers<CR>

" silent! call airline#extensions#whitespace#disable()

inoremap jj <ESC>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

tnoremap jj <C-\><C-n>

command! -complete=file -nargs=1 T tabedit <args>
command! NT NERDTree
command! W w
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
command! -nargs=0 Sw w !sudo tee % > /dev/null
command! Hexedit :%!hexdump -C
command! -nargs=1 W3m !w3m <f-args>

colorscheme ayu

luafile ~/.config/nvim/statline.lua

function! PresentationMode()
  set nonumber  
  set norelativenumber
  set nocursorline
endfunction
