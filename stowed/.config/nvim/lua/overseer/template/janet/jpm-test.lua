local overseer = require 'overseer'

return {
  name = "JPM Test",
  builder = function()
    return {
      cmd = { 'jpm' },
      args = { "test" },
      name = "jpm test",
      components = {
        "on_exit_set_status",
        {
          "on_complete_notify",
          system = "unfocused"
        },
        {
          "on_output_quickfix",
          open = true,
          open_height = 8,
          open_on_exit = "failure"
        },
      },
      metadata = {},
    }
  end,
  desc = "JPM Test Project",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    callback = function()
      return vim.fn.filereadable('project.janet') == 1
    end
  },
}
