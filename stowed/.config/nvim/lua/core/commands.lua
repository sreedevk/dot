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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "janet",
  callback = function()
    vim.bo.commentstring = "# %s"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.opt.wrap = false
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    local function extend_hl(name, def)
      local old = vim.api.nvim_get_hl(0, { name = name })
      local new = vim.tbl_extend("force", {}, old, def)
      vim.api.nvim_set_hl(0, name, new)
    end
    extend_hl("@keyword.function.ruby", { bold = true })
    extend_hl("@keyword.conditional.ruby", { bold = true })
    extend_hl("@variable.builtin.ruby", { bold = true })
    extend_hl("@constant.ruby", { bold = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "janet",
  callback = function()
    vim.keymap.set(
      "n",
      "<Leader>re",
      '<cmd>TermExec cmd="janet -l ./%:r" direction=horizontal<cr>',
      {
        buffer = true,
        desc = "Open Repl",
        noremap = true,
      }
    )
  end
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
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
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
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    vim.opt.signcolumn = 'yes'
    vim.bo[event.buf].formatexpr = nil
    vim.bo[event.buf].omnifunc = nil

    vim.diagnostic.config {
      virtual_lines = false, -- { current_line = true },
      virtual_text = { current_line = true },
    }

    local format_buf_async = function()
      vim.lsp.buf.format({ async = true })
    end

    vim.keymap.set('n', '<Leader>ff', format_buf_async, { noremap = true })
    vim.keymap.set({ "n", "v" }, "<Leader>ff", vim.lsp.buf.format, { noremap = true, desc = "LSP Format" })

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
