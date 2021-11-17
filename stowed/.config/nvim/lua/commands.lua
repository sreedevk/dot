-- PLUGIN / INBUILD COMMAND MAPPINGS
vim.cmd(
  [[
    command! -complete=file -nargs=1 T tabedit <args>
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
    command! -nargs=0 Sw w !sudo tee % > /dev/null
    command! Filetypes Telescope filetypes
    command! W w
    command! Wq wq
    command! WQ wq
    command! Q q
  ]]
)

-- CUSTOM COMMANDS
vim.cmd(
  [[
    command! PresentationMode lua require('funk').presentation_mode()
    command! RemoveComments lua require('funk').remove_comments()
    command! Projects lua require'telescope'.extensions.project.project{}
  ]]
)
