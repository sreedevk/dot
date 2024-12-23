---------------------------------------------------------------------
--------------------- RSPEC MODULE START ----------------------------
---------------------------------------------------------------------

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
    command = "bin/rspec",
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

Rspec.is_enabled = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  return vim.endswith(bufname, "_spec.rb")
end

---------------------------------------------------------------------
--------------------- RSPEC MODULE END ------------------------------
---------------------------------------------------------------------

return {
  "quolpr/quicktest.nvim",
  config = function()
    local qt = require("quicktest")
    qt.setup({
      adapters = {
        Rspec,
        require("quicktest.adapters.golang")({
          additional_args = function(_)
            return { "-race", "-count=1" }
          end,
        }),
        require("quicktest.adapters.vitest")({}),
        require("quicktest.adapters.playwright")({}),
        require("quicktest.adapters.elixir"),
        require("quicktest.adapters.criterion"),
        require("quicktest.adapters.dart"),
      },
      default_win_mode = "split",
      use_baleia = false,
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/trouble.nvim"
  },
  keys = {
    {
      "<leader>tl",
      function()
        local qt = require("quicktest")
        qt.run_line()
      end,
      desc = "[T]est Run [L]line",
    },
    {
      "<leader>tf",
      function()
        local qt = require("quicktest")

        qt.run_file()
      end,
      desc = "[T]est Run [F]ile",
    },
    {
      "<leader>td",
      function()
        local qt = require("quicktest")

        qt.run_dir()
      end,
      desc = "[T]est Run [D]ir",
    },
    {
      "<leader>ta",
      function()
        local qt = require("quicktest")

        qt.run_all()
      end,
      desc = "[T]est Run [A]ll",
    },
    {
      "<leader>tp",
      function()
        local qt = require("quicktest")

        qt.run_previous()
      end,
      desc = "[T]est Run [P]revious",
    },
    {
      "<leader>tw",
      function()
        local qt = require("quicktest")

        qt.toggle_win("split")
      end,
      desc = "[T]est Toggle [W]indow",
    },
    {
      "<leader>tc",
      function()
        local qt = require("quicktest")

        qt.cancel_current_run()
      end,
      desc = "[T]est [C]ancel Current Run",
    },
  },
}
