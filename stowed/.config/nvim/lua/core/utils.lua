local M = {}

local function snake_to_camel(word)
  return word:gsub("_(.)", function(c)
    return c:upper()
  end)
end

local function camel_to_snake(word)
  return word:gsub("(%u)", "_%1"):lower()
end

function M.convert_cword_to_camel()
  local cword = vim.fn.expand("<cword>")
  local camelCaseWord = snake_to_camel(cword)
  vim.cmd('normal! "_ciw' .. camelCaseWord)
end

function M.convert_cword_to_snake()
  local cword = vim.fn.expand("<cword>")
  local snakeCaseWord = camel_to_snake(cword)
  vim.cmd('normal! "_ciw' .. snakeCaseWord)
end

function M.colorize()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.statuscolumn = ""
  vim.wo.signcolumn = "no"
  vim.opt.listchars = { space = " " }

  local buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    lines[#lines] = nil
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  vim.b[buf].minianimate_disable = true

  vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, "\r\n"))
  vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true, buffer = buf })
  vim.api.nvim_create_autocmd("TextChanged", { buffer = buf, command = "normal! G$" })
  vim.api.nvim_create_autocmd("TermEnter", { buffer = buf, command = "stopinsert" })

  vim.defer_fn(function()
    vim.b[buf].minianimate_disable = false
  end, 2000)
end

return M
