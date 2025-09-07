local M = {}

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

local function gen_lang_conf(conf)
  local baseconf = {
    cmd = conf.cmd,
    filetypes = conf.filetypes,
    root_markers = conf.root_markers or { ".git" },
    single_file_support = conf.single_file_support or true,
  }

  if conf.settings then
    baseconf = vim.tbl_deep_extend('error', baseconf, { settings = conf.settings })
  end

  if conf.init_options then
    baseconf = vim.tbl_deep_extend('error', baseconf, { init_options = conf.init_options })
  end

  if conf.get_language_id then
    baseconf = vim.tbl_deep_extend('error', baseconf, { get_language_id = conf.get_language_id })
  end

  if conf.on_attach then
    baseconf = vim.tbl_deep_extend('error', baseconf, { on_attach = conf.on_attach })
  end

  return baseconf
end

function M.setup_lsp(conf)
  if conf.enable then
    vim.lsp.config[conf.name] = gen_lang_conf(conf)
    vim.lsp.enable(conf.name)
  end
end

function M.wrap_cmd(cmd)
  return function() vim.cmd(cmd) end
end

return M
