local overseer = require("overseer")

return {
  name = "HomeManager Switch",
  builder = function()
    return {
      cmd = { 'home-manager' },
      args = { "switch", "--flake", "./nixos", "--impure", "-j", "20" },
      name = "home-manager switch",
      cwd = vim.fn.expand("~") .. "/.dot",
      env = {},
      components = {
        "default",
        {
          "open_output",
          on_complete = "never",
          on_start = "always"
        },
        {
          "on_complete_dispose",
          statuses = { "success" }
        }
      },
      metadata = {},
    }
  end,
  desc = "Home Manager Configuration Apply",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    dir = vim.fn.expand("~") .. "/.dot",
  },
}
