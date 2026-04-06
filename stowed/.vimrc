set runtimepath+=~/.vim,~/.vim/after

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-rooter'
Plug 'bling/vim-airline'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'chrisbra/csv.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jdhao/better-escape.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'ledger/vim-ledger'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'nanotee/zoxide.vim'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod',
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar',
Plug 'vim-ruby/vim-ruby'

call plug#end()

filetype plugin indent on    " required
syntax on
colorscheme catppuccin_mocha

set tabstop=2
set shiftwidth=2
set softtabstop=2
set scrolloff=10
set sidescrolloff=10
set breakat=[[\ \	;:,!?]]
set clipboard=unnamedplus
set breakindentopt=shift:2,min:20
set breakindent
set smartindent
set number
set expandtab
set incsearch
set infercase
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
set matchpairs=(:),{:},[:],<:>
set list " show trailing whitespaces
set ruler
set cursorline
set clipboard=unnamedplus

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

if &term =~ '256color'
  set t_ut=
endif

let mapleader = ";"
let g:better_escape_shortcut = 'jj'
let g:better_escape_interval = 400
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:user_emmet_expandabbr_key = '<C-c>,'
let g:user_emmet_leader_key = '<C-c>'
let g:deoplete#enable_at_startup = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 0 
let g:NERDTreeWinSize=20
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint --type-check']
let g:syntastic_typescript_tslint_args = "--config ~/.config/nvim/add_conf/tslint.json"
let g:EasyMotion_smartcase = 1
let g:airline#extensions#tabline#enabled = 1

map <Leader> <Plug>(easymotion-prefix)

nmap <C-n> :NERDTreeToggle<CR>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <C-t> :tabnew <CR>

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR> 
nnoremap <Leader>fs :w!<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>h :noh<CR>

noremap <Leader>srr :sort<cr>
noremap <Leader>srn :sort n<cr>
noremap <Leader>sru :sort u<cr>

"terminal
nnoremap <C-4><C-4> :terminal<CR>

" git
nnoremap <Leader>gi  :Git<CR>
nnoremap <Leader>glg :Git log --oneline --decorate --graph<CR>
nnoremap <Leader>glo :Git log<CR>
nnoremap <Leader>gpu :Git push<CR>
nnoremap <Leader>gpl :Git pull<CR>
nnoremap <Leader>gb  :Git blame<CR>

" buffers
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bb :bnext<CR>
nnoremap <Leader>bB :bprev<CR>
nnoremap <Leader>bl :Buffers<CR>

" spell
nnoremap <Leader>sp :setlocal spell!<CR>

" utils
nnoremap <Leader>sw <cmd>SudoWrite<cr>
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
nnoremap <Leader>x <cmd>! chmod +x %<CR>
nnoremap <leader><leader>s :%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left> 
nnoremap <Leader>ca <cmd>tabonly<CR>
nnoremap <Leader>zi <cmd>Zi<CR>

" fzf
nnoremap <Leader>p  <cmd>GFiles<cr>
nnoremap <C-p>      <cmd>FZF<cr>
nnoremap <Leader>rg <cmd>RG<cr>

nnoremap , :
vnoremap , :
nnoremap n nzzzv
nnoremap N Nzzzv

silent! call airline#extensions#whitespace#disable()

tnoremap jj <C-\><C-n>

command! -complete=file -nargs=1 T tabedit <args>
command! NT NERDTree
command! W w
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
