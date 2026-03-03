return {
  {
    'stevearc/overseer.nvim',
    keys = {
      { '<Leader>rnn', '<cmd>OverseerRun<cr>',    desc = "Run Command",           noremap = true },
      { '<Leader>rno', '<cmd>OverseerToggle<cr>', desc = "Toggle Command Runner", noremap = true }
    },
    ---@type overseer.SetupOpts
    opts = {
      output = {
        preserve_output = true,
        use_terminal = false,
      },
      task_list = {
        render = function(task)
          return require("overseer.render").format_standard(task)
        end,
        keymaps = {
          ["?"] = "keymap.show_help",
          ["g?"] = "keymap.show_help",
          ["<CR>"] = "keymap.run_action",
          ["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "Dispose task" },
          ["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
          ["o"] = "keymap.open",
          ["<C-v>"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "Open task output in vsplit" },
          ["<C-s>"] = { "keymap.open", opts = { dir = "split" }, desc = "Open task output in split" },
          ["<C-t>"] = { "keymap.open", opts = { dir = "tab" }, desc = "Open task output in tab" },
          ["<C-f>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
          ["<C-q>"] = {
            "keymap.run_action",
            opts = { action = "open output in quickfix" },
            desc = "Open task output in the quickfix",
          },
          ["p"] = "keymap.toggle_preview",
          ["{"] = "keymap.prev_task",
          ["}"] = "keymap.next_task",
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
        "hledger"
      },
      auto_detect_success_color = true,
      dap = false,
    },
  }
}
