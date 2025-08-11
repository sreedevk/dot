local Job = require("plenary.job")
local Rspec = { name = "rspec-adapter", }

Rspec.get_cwd = function(_)
  return vim.fn.getcwd()
end

Rspec.build_line_run_params = function(bufnr, cursor_pos)
  local cwd = Rspec.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)

  return { bufnr = bufnr, cursor_pos = cursor_pos, cwd = cwd, file = file, func_names = {}, pos = cursor_pos[1] }, nil
end

Rspec.build_file_run_params = function(bufnr, cursor_pos)
  local cwd = Rspec.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)

  return { bufnr = bufnr, cursor_pos = cursor_pos, cwd = cwd, file = file }, nil
end

Rspec.run = function(params, send)
  local args = {}

  if params.file then
    local f = params.file

    if params.pos then
      f = f .. ":" .. params.pos
    end

    table.insert(args, f)
  end

  local job = Job:new({
    command   = "bin/rspec",
    args      = args,
    on_stdout = function(_, data) send({ type = "stdout", output = data or "" }) end,
    on_stderr = function(_, data) send({ type = "stderr", output = data or "" }) end,
    on_exit   = function(_, retn) send({ type = "exit", code = retn }) end,
  })

  job:start()

  return job.pid
end

Rspec.is_enabled = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  return vim.endswith(bufname, "_spec.rb")
end

return Rspec
