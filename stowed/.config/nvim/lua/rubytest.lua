local Job = require("plenary.job")
-- local fs = require("quicktest.fs_utils")

local M = {
  name = "myadapter",
}
---@class MyRunParams
---@field func_names string[]
---@field bufnr integer
---@field cursor_pos integer[]

M.get_cwd = function(bufnr)
  return vim.fn.getcwd()
end

--- Optional:
--- Builds parameters for running tests based on buffer number and cursor position.
--- This function should be customized to extract necessary information from the buffer.
---@param bufnr integer
---@param cursor_pos integer[]
---@return MyRunParams, nil | string
M.build_line_run_params = function(bufnr, cursor_pos)
  -- You can get current function name to run based on bufnr and cursor_pos
  -- Check hot it is done for golang at `lua/quicktest/adapters/golang`
  local cwd = M.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr) -- Get the current buffer's file path

  return {
        bufnr = bufnr,
        cursor_pos = cursor_pos,
        cwd = cwd,
        file = file,
        func_names = {},
        pos = cursor_pos[1],
        -- Add other parameters as needed
      },
      nil
end

--- Optional:
---@param bufnr integer
---@param cursor_pos integer[]
---@return MyRunParams, nil | string
M.build_file_run_params = function(bufnr, cursor_pos)
  local cwd = M.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr) -- Get the current buffer's file path

  return {
        bufnr = bufnr,
        cursor_pos = cursor_pos,
        cwd = cwd,
        file = file,
        -- Add other parameters as needed
      },
      nil
end

--- Optional:
---@param bufnr integer
---@param cursor_pos integer[]
---@return MyRunParams, nil | string
-- M.build_dir_run_params = function(bufnr, cursor_pos)
--   return {
--     bufnr = bufnr,
--     cursor_pos = cursor_pos,
--     -- Add other parameters as needed
--   }, nil
-- end

--- Optional:
---@param bufnr integer
---@param cursor_pos integer[]
---@return MyRunParams, nil | string
-- M.build_all_run_params = function(bufnr, cursor_pos)
--   return {
--     bufnr = bufnr,
--     cursor_pos = cursor_pos,
--     -- Add other parameters as needed
--   }, nil
-- end

--- Executes the test with the given parameters.
---@param params MyRunParams
---@param send fun(data: any)
---@return integer
M.run = function(params, send)
  args = {}

  if params.file then
    local f = params.file

    if params.pos then
      f = f .. ":" .. params.pos
    end

    table.insert(args, f)
  end

  local job = Job:new({
    command = "bin/rspec",
    -- config_path = fs.root_pattern("Gemfile"),
    args = args,

    on_stdout = function(_, data)
      send({ type = "stdout", output = data })
    end,
    on_stderr = function(_, data)
      send({ type = "stderr", output = data })
    end,
    on_exit = function(_, return_val)
      send({ type = "exit", code = return_val })
    end,
  })

  job:start()

  return job.pid
end

--- Optional: title of the test run
---@param params MyRunParams
-- M.title = function(params)
--   return "Running test"
-- end

--- Optional: handles actions to take after the test run, based on the results.
---@param params any
---@param results any
-- M.after_run = function(params, results)
--   -- Implement actions based on the results, such as updating UI or handling errors
-- end

--- Checks if the adapter is enabled for the given buffer.
---@param bufnr integer
---@return boolean
M.is_enabled = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  return vim.endswith(bufname, "_spec.rb")
end

return M
