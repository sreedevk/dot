vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q', {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "markdown", "text" },
  callback = function()
    vim.opt_local.spelllang = "en"
    vim.opt_local.spellfile = vim.fn.expand(vim.g.dotfiles .. "/stowed/.config/nvim/spell/en.utf-8.add")
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
