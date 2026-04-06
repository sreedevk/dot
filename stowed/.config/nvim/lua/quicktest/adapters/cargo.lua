local Job = require("plenary.job")
local CargoTest = { name = "cargo-test-adapter" }

local function find_cargo_root(start_path)
  local uv = vim.loop
  local root = uv.fs_realpath(start_path) or start_path
  while root do
    local cargo_toml = uv.fs_stat(root .. "/Cargo.toml")
    if cargo_toml and cargo_toml.type == "file" then
      return root
    end
    local parent = uv.fs_realpath(root .. "/..")
    if parent == root then break end
    root = parent
  end
  return nil
end

CargoTest.get_cwd = function(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)
  if file and file ~= "" then
    local dir = vim.fn.fnamemodify(file, ":h")
    local root = find_cargo_root(dir)
    if root then
      return root
    end
  end
  return vim.fn.getcwd()
end

local function get_test_name_at_position(bufnr, line)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, line, false)
  local total_lines = #lines
  if total_lines == 0 then return nil end

  for i = line - 1, 0, -1 do
    local current_line = lines[i + 1]
    if current_line:find("%s*#%[.*test.*%]") then
      local func_name = current_line:match("fn%s+([%w_]+)")
      if func_name then
        return func_name
      end
      if i + 1 < total_lines then
        local next_line = lines[i + 2]
        func_name = next_line and next_line:match("fn%s+([%w_]+)")
        if func_name then
          return func_name
        end
      end
    end
  end
  return nil
end

local function get_test_filter_for_file(_, cwd, file)
  local rel_path = file:sub(#cwd + 2)
  if not rel_path or rel_path == "" then
    return nil
  end

  if rel_path:match("^tests/") then
    local filename = vim.fn.fnamemodify(rel_path, ":t:r")
    return {
      type = "integration",
      value = filename,
    }
  end

  if rel_path:match("^src/") then
    local mod_path = rel_path:gsub("^src/", ""):gsub("%.rs$", "")
    mod_path = mod_path:gsub("/", "::")

    if mod_path == "" or mod_path == "lib" or mod_path == "main" then
      return {
        type = "unit_root",
        value = nil,
      }
    else
      return {
        type = "unit",
        value = mod_path .. "::",
      }
    end
  end

  return nil
end

local function get_test_filter_for_dir(_, cwd, dir)
  local rel_path = dir:sub(#cwd + 2)
  if not rel_path or rel_path == "" then
    return { type = "all" }
  end

  if rel_path:match("^tests/") then
    return { type = "all" }
  end

  if rel_path:match("^src/") then
    local mod_path = rel_path:gsub("^src/", "")
    mod_path = mod_path:gsub("/", "::") .. "::"
    return {
      type = "unit_dir",
      value = mod_path,
    }
  end

  return { type = "all" }
end

CargoTest.build_line_run_params = function(bufnr, cursor_pos)
  local cwd = CargoTest.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)
  local line = cursor_pos[1]

  local test_name = get_test_name_at_position(bufnr, line)
  local func_names = test_name and { test_name } or {}

  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    cwd = cwd,
    file = file,
    func_names = func_names,
    pos = line,
    filter_type = nil,
    filter_value = nil,
  }, nil
end

CargoTest.build_file_run_params = function(bufnr, cursor_pos)
  local cwd = CargoTest.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)

  local filter = get_test_filter_for_file(bufnr, cwd, file)

  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    cwd = cwd,
    file = file,
    func_names = {},
    pos = cursor_pos[1],
    filter_type = filter and filter.type,
    filter_value = filter and filter.value,
  }, nil
end

CargoTest.build_dir_run_params = function(bufnr, cursor_pos)
  local cwd = CargoTest.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fn.fnamemodify(file, ":h")

  local filter = get_test_filter_for_dir(bufnr, cwd, dir)

  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    cwd = cwd,
    file = file,
    dir = dir,
    func_names = {},
    pos = cursor_pos[1],
    filter_type = filter and filter.type,
    filter_value = filter and filter.value,
  }, nil
end

CargoTest.build_all_run_params = function(bufnr, cursor_pos)
  local cwd = CargoTest.get_cwd(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)

  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    cwd = cwd,
    file = file,
    func_names = {},
    pos = cursor_pos[1],
    filter_type = "all",
    filter_value = nil,
  }, nil
end

CargoTest.run = function(params, send)
  local args = { "test" }

  if params.filter_type == "integration" then
    table.insert(args, "--test")
    table.insert(args, params.filter_value)
  elseif params.filter_type == "unit" then
    table.insert(args, params.filter_value)
  elseif params.filter_type == "unit_root" then
    table.insert(args, "--lib")
  elseif params.filter_type == "unit_dir" then
    table.insert(args, params.filter_value)
  elseif params.filter_type == "all" then
  elseif params.func_names and #params.func_names > 0 then
    table.insert(args, params.func_names[1])
  end

  local job = Job:new({
    command = "cargo",
    args = args,
    cwd = params.cwd,
    on_stdout = function(_, data) send({ type = "stdout", output = data or "" }) end,
    on_stderr = function(_, data) send({ type = "stderr", output = data or "" }) end,
    on_exit = function(_, retn) send({ type = "exit", code = retn }) end,
  })

  job:start()
  return job.pid
end

CargoTest.is_enabled = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if not bufname:match("%.rs$") then return false end
  local cwd = CargoTest.get_cwd(bufnr)
  local cargo_toml = vim.loop.fs_stat(cwd .. "/Cargo.toml")
  return cargo_toml and cargo_toml.type == "file"
end

return CargoTest
