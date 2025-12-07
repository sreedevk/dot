vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q', {})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Spellcheck on Text Documents",
  pattern = { "html", "markdown", "text", "gemtext" },
  group = vim.api.nvim_create_augroup("enable_spell_on_text_docs", {}),
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight Yanked Text for Clarity",
  pattern = "*",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function(_)
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Do not add comment leader when using O/o to insert new line",
  pattern = "*",
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "o" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Aux Buffer Conveniences",
  pattern = vim.g.auxbuffers,
  group = vim.api.nvim_create_augroup("quick_quit_aux_bufs", {}),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>quit<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Open help docs on vertical splits to the right",
  pattern = "help",
  command = "wincmd L"
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Disable LSP Diagnostic Virtual Lines (tiny lsp diagnostics plugin)",
  group = vim.api.nvim_create_augroup("disable_virtual_line_diagnostics", {}),
  callback = function(_)
    vim.diagnostic.config {
      virtual_lines = false, -- { current_line = true }
      virtual_text = false,  -- { current_line = true }
    }
  end
})
