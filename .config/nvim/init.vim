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

luafile ~/.config/nvim/lua/init.lua

filetype plugin indent on
syntax on

let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint --type-check']
let g:githb_enterprise_urls = ['https://github.tunecore.co']
set t_Co=256

autocmd CursorHold * checktime

" custom commands
command! -complete=file -nargs=1 T tabedit <args>
command! W w
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
command! -nargs=0 Sw w !sudo tee % > /dev/null
command! -nargs=1 W3m !w3m <f-args>

" custom functions
function! PresentationMode()
  set nonumber  
  set norelativenumber
  set nocursorline
endfunction
