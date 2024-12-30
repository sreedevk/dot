local overseer = require("overseer")

return {
  name = "Janet Compile",
  builder = function()
    return {
      cmd = { 'janet' },
      args = { "--compile", vim.fn.expand("%"), vim.fn.expand("%:r") .. ".jimage" },
      name = "janet compile",
      components = {
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
  desc = "Janet Compile Jimage",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    filetype = { "janet" },
  },
}
