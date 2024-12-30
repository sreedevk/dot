local overseer = require "overseer"

return {
  name = "Flake Update",
  builder = function()
    return {
      cmd = { 'nix' },
      args = { "flake", "update", "--flake", "./nixos" },
      name = "nix flake update",
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
  desc = "Update Nix Flake",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    dir = vim.fn.expand("~") .. "/.dot",
  },
}
