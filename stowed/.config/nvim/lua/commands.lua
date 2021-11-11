-- COMMANDS
vim.cmd(
  [[
    command! -complete=file -nargs=1 T tabedit <args>
    command! W w
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
    command! -nargs=0 Sw w !sudo tee % > /dev/null
    command! -nargs=1 W3m !w3m <f-args>
    command! Filetypes :Telescope filetypes
  ]]
)
