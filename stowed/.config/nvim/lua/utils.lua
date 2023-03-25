local M = {}

-- run command in toggle term
function M.prun()
  local term    = require('toggleterm.terminal').Terminal
  local command = vim.fn.input("cmd: ", "", "file")
  command       = string.gsub(command, '%%', vim.fn.expand('%'))
  local cmdterm = term:new({ cmd = command, hidden = false })
  cmdterm:toggle()
end

-- run command asynchronously
function M.arun()
  local term    = require('toggleterm.terminal').Terminal
  local command = vim.fn.input("async cmd: ", "", "file")
  command       = string.gsub(command, '%%', vim.fn.expand('%'))
  local cmdterm = term:new({ cmd = command, hidden = false })
  cmdterm:spawn()
end

-- venn.nvim: enable or disable keymappings
function M.toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd [[setlocal ve=all]]
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
  else
    vim.cmd [[setlocal ve=]]
    vim.cmd [[mapclear <buffer>]]
    vim.b.venn_enabled = nil
  end
end

return M
