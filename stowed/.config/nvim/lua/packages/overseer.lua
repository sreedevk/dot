return {
  {
    'stevearc/overseer.nvim',
    keys = {
      { '<Leader>rnn', '<cmd>OverseerRun<cr>',    desc = "Run Command",           noremap = true },
      { '<Leader>rno', '<cmd>OverseerToggle<cr>', desc = "Toggle Command Runner", noremap = true },
      {
        '<Leader><Leader>r',
        ":OverseerShell ",
        desc = "Async Run",
        noremap = true,
      },
      {
        '<leader>or',
        function()
          local overseer = require("overseer")
          local task_list = require("overseer.task_list")
          local tasks = overseer.list_tasks({
            status = {
              overseer.STATUS.SUCCESS,
              overseer.STATUS.FAILURE,
              overseer.STATUS.CANCELED,
            },
            sort = task_list.sort_finished_recently
          })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            local most_recent = tasks[1]
            overseer.run_action(most_recent, "restart")
          end
        end,
        desc = "restart last task",
        noremap = true
      }
    },
    ---@type overseer.SetupOpts
    opts = {
      output = {
        preserve_output = true,
        use_terminal = false,
      },
      component_aliases = {
        default = {
          { "display_duration",   detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_notify",
          "on_complete_dispose",
          { "on_output_quickfix", set_diagnostics = true },
          "on_result_diagnostics",
        },
      },
      task_list = {
        render = function(task)
          return require("overseer.render").format_standard(task)
        end,
        keymaps = {
          ["?"] = "keymap.show_help",
          ["g?"] = "keymap.show_help",
          ["gd"] = {
            function()
              for _, task in ipairs(require("overseer").list_tasks()) do
                task:dispose()
              end
            end,
            mode = "n",
            nowait = true,
            desc = "Dispose all tasks"
          },
          ["<CR>"] = "keymap.run_action",
          ["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "dispose task" },
          ["r"] = { "keymap.run_action", opts = { action = "restart" }, desc = "restart task" },
          ["x"] = { "keymap.run_action", opts = { action = "stop" }, desc = "stop task" },
          ["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
          ["o"] = "keymap.open",
          ["v"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "open task output in vsplit" },
          ["s"] = { "keymap.open", opts = { dir = "split" }, desc = "open task output in split" },
          ["t"] = { "keymap.open", opts = { dir = "tab" }, desc = "open task output in tab" },
          ["f"] = { "keymap.open", opts = { dir = "float" }, desc = "open task output in float" },
          ["<C-q>"] = {
            "keymap.run_action",
            opts = { action = "open output in quickfix" },
            desc = "open task output in the quickfix",
          },
          ["p"] = "keymap.toggle_preview",
          ["["] = "keymap.prev_task",
          ["]"] = "keymap.next_task",
          ["<C-k>"] = "keymap.scroll_output_up",
          ["<C-j>"] = "keymap.scroll_output_down",
          ["g."] = "keymap.toggle_show_wrapped",
          ["q"] = { "<CMD>close<CR>", desc = "Close task list" },
        },
      },
      template_dirs = { "overseer.template" },
      templates = {
        "builtin",
        "janet",
        "hledger",
      },
      auto_detect_success_color = true,
      dap = false,
    },
  }
}
