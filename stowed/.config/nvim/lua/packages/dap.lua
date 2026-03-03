return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup(opts)

          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end

          dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = {
              "--interpreter=dap",
              "--eval-command",
              "set print pretty on",
            }
          }

          dap.adapters["rust-gdb"] = {
            type = "executable",
            command = "rust-gdb",
            args = {
              "--interpreter=dap",
              "--eval-command",
              "set print pretty on",
            }
          }

          dap.configurations.rust = {
            {
              name = "Launch",
              type = "rust-gdb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              args = {},
              cwd = "${workspaceFolder}",
              stopAtBeginningOfMainSubprogram = false,
            },
            {
              name = "Select and attach to process",
              type = "rust-gdb",
              request = "attach",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
              end,
              cwd = "${workspaceFolder}"
            },
            {
              name = "Attach to gdbserver :1234",
              type = "rust-gdb",
              request = "attach",
              target = "localhost:1234",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}'
            }
          }

          dap.configurations.c = {
            {
              name = "Launch",
              type = "gdb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              args = {},
              cwd = "${workspaceFolder}",
              stopAtBeginningOfMainSubprogram = false,
            },
            {
              name = "Select and attach to process",
              type = "gdb",
              request = "attach",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
              end,
              cwd = '${workspaceFolder}'
            },
            {
              name = 'Attach to gdbserver :1234',
              type = 'gdb',
              request = 'attach',
              target = 'localhost:1234',
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}'
            }
          }
          dap.configurations.cpp = dap.configurations.c
        end,
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "x" } },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
  }
}
