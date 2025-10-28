vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q', {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "markdown", "text", "gemtext" },
  callback = function()
    vim.opt_local.spelllang = "en"
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function(event)
    vim.highlight.on_yank()
    vim.opt_local.formatoptions:remove({ "o" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.g.auxbuffers,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>quit<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { 'gitcommit', 'gitrebase' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>wq<CR>", { buffer = event.buf, silent = true })
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Configurations on LSP Attach",
  callback = function(_)
    vim.diagnostic.config {
      virtual_lines = false, -- { current_line = true },
      virtual_text = false, 
      -- virtual_text = { current_line = true },
    }
  end
})
