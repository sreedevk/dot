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
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.implementation, { desc = "LSP: Go to implementation" })
    vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })

    vim.keymap.set({ "n", "x" }, "<leader>clr", vim.lsp.codelens.run, { desc = "LSP: Codelens Run" })
    vim.keymap.set({ "n", "x" }, "<leader>clR", vim.lsp.codelens.refresh, { desc = "LSP: Codelens Refresh" })

    vim.keymap.set(
      { 'n', 'v' },
      '<Leader>ff',
      function() vim.lsp.buf.format({ async = true }) end,
      { desc = "Format Text", noremap = true }
    )

    vim.diagnostic.config {
      virtual_lines = false, -- { current_line = true }
      virtual_text = false,  -- { current_line = true }
    }
  end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", {}),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
