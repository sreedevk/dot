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

--------------- START RUN CMD UTILS ---------------
function M.arun()
  local term    = require('toggleterm.terminal').Terminal
  local command = vim.fn.input("async cmd: ", "", "file")
  command       = string.gsub(command, '%%', vim.fn.expand('%'))
  local cmdterm = term:new({ cmd = command, hidden = false })
  cmdterm:spawn()
end

--------------- END RUN CMD UTILS ---------------

-- empty swap
function M.emptyswap()
  local swap_dir = vim.fn.expand('$HOME') .. '/.local/state/nvim/swap/'
  local files = vim.fn.glob(swap_dir .. '*.swp', false, true)
  for _, file in ipairs(files) do
    os.remove(file)
  end

  print('deleted ' .. #files .. ' swap files')
end

return M
