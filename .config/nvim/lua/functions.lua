local M = {}
-- Switch to Presentation View
function M.PresentationMode()
  -- 0th buffer is the current buffer
  vim.bo[0].number         = false
  vim.bo[0].relativenumber = false
  vim.bo[0].cursorline     = false
end

return M
