local api = vim.api

local Helpers = {}
function Helpers.create_augroups(definitions)
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

return Helpers
