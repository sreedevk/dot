local api = vim.api

local M = {}
function M.create_augroups(definitions)
  for group_name, group_definitions in pairs(definitions) do
    local group = api.nvim_create_augroup(group_name, { clear = true })
    for _, definition in ipairs(group_definitions) do
      api.nvim_create_autocmd(
        definition[1],
        {
          command = definition[3],
          pattern = definition[2],
          group = group,
        }
      )
    end
  end
end

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
