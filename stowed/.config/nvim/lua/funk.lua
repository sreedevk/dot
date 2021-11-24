local M = {}
-- Switch to Presentation View
function M.presentation_mode()
  -- 0th buffer is the current buffer
  vim.wo[0].number         = false
  vim.wo[0].relativenumber = false
  vim.wo[0].cursorline     = false
end

function M.remove_comments()
  vim.cmd([[:g/\v^(#|\/\/)/d]])
  vim.cmd([[:g/\v^\s*(#|\/\/)/d]])
end

function M.neovim_config()
  vim.cmd([[:e ~/.config/nvim]])
end

return M
