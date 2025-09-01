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
  command = "silent! lua vim.highlight.on_yank()"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=o"
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
    vim.opt.signcolumn = 'yes'
    vim.diagnostic.config {
      virtual_lines = false, -- { current_line = true },
      virtual_text = { current_line = true },
    }

    local conform_ok, conform = pcall(require, 'conform')
    if conform_ok then
      vim.keymap.set(
        { 'n', 'v' },
        '<Leader>ff',
        function() conform.format({ async = true, lsp_fallback = true }) end,
        { noremap = true }
      )
    else
      vim.keymap.set(
        { 'n', 'v' },
        '<Leader>ff',
        function() vim.lsp.buf.format({ async = true }) end,
        { noremap = true }
      )
    end

    -- grn        : rename
    -- grr        : references
    -- gri        : goto implementation
    -- g0         : document symbol
    -- gra        : code action
    -- CTRL-S     : signature help
    -- [d and ]d  : jump b/w diagnostics
    -- [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
    -- [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location list
    -- [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag matchlist
    -- [a, ]a, [A, ]A navigate through the argument list
    -- [b, ]b, [B, ]B navigate through the buffer list
    -- [<Space>, ]<Space> add an empty line above and below the cursor
  end
})
