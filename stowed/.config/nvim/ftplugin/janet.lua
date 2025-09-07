vim.bo.commentstring = "# %s"
vim.keymap.set("n", "<Leader>re", '<cmd>TermExec cmd="janet -l ./%:r" direction=horizontal<cr>', {
  buffer = true,
  desc = "Open Repl",
  noremap = true,
})
