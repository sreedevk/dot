local M = {}
-- Switch to Presentation View
function M.PresentationMode()
  -- 0th buffer is the current buffer
  vim.bo[0].number         = false
  vim.bo[0].relativenumber = false
  vim.bo[0].cursorline     = false
end

function M.smart_tab()
  if vim.fn.pumvisible() ~= 0 then
    vim.api.nvim_eval([[feedkeys("\<c-n>", "n")]])
    return
  end

  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    vim.api.nvim_eval([[feedkeys("\<tab>", "n")]])
    return
  end

  vim.fn["compe#complete"]();
end

return M
