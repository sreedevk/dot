local M = {}

--------------- START CONVERT CASE UTILS ---------------
local function snake_to_camel(word)
  return word:gsub("_(.)", function(c)
    return c:upper()
  end)
end

function M.convert_cword_to_camel()
  local cword = vim.fn.expand("<cword>")
  local camelCaseWord = snake_to_camel(cword)
  vim.cmd('normal! "_ciw' .. camelCaseWord)
end

--------------- END CONVERT CASE UTILS ---------------


--------------- START FETCH JSON UTILS ---------------
function M.fetchjson()
  local url    = vim.fn.expand('<cWORD>')
  local handle = io.popen('curl ' .. url)

  if handle == nil then
    print('Error: Failed to load httpie')
    return
  end

  local response = handle:read('*a')
  handle:close()

  if response == '' then
    print('Error: Failed to fetch URL')
    return
  end

  local jq_cmd = string.format([[echo '%s' | jq]], response)
  local jq_handle = io.popen(jq_cmd)
  local formatted_json = ""
  local lines = {}

  if jq_handle ~= nil then
    formatted_json = jq_handle:read("*a")
    jq_handle:close()
    for line in string.gmatch(formatted_json, "[^\r\n]+") do
      table.insert(lines, line)
    end
  else
    lines = { response }
  end

  vim.cmd('vsplit')

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'json')
  vim.api.nvim_win_set_buf(win, buf)

  print('Success: Fetched URL')
end

--------------- END FETCH JSON UTILS ---------------

return M
