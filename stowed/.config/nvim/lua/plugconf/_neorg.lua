local neorg_ok, neorg = pcall(require, "neorg")
if not neorg_ok then
  return
end

neorg.setup {
  load = {
    ["core.norg.concealer"] = {},
    ["core.clipboard.code-blocks"] = {},
    ["core.keybinds"] = {
      config = {
        neorg_leader = ";"
      }
    },
    ["core.looking-glass"] = {},
    ["core.norg.esupports.hop"] = {},
    ["core.norg.esupports.metagen"] = {},
    ["core.norg.esupports.indent"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.norg.qol.todo_items"] = {},
    ["core.upgrade"] = {},
    ["core.tangle"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Data/notebook/"
        },
      },
    },
    ["core.norg.journal"] = {
      config = {
        strategy = "flat",
        workspace = "notes",
      }
    },
    ["core.integrations.telescope"] = {}
  },
}

local neorg_callbacks_ok, neorg_callbacks = pcall(require, "neorg.callbacks")
if not neorg_callbacks_ok then
  return
end

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  keybinds.map_event_to_mode("norg", {
    n = {
      { "<C-s>", "core.integrations.telescope.find_linkable" },
    },
    i = {
      { "<C-l>", "core.integrations.telescope.insert_link" },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)
