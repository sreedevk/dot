return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup()

    vim.keymap.set("n", "<Leader>fa", function() harpoon:list():append() end)
    vim.keymap.set("n", "<Leader>fl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<Leader>f1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<Leader>f2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<Leader>f3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<Leader>f4", function() harpoon:list():select(4) end)
  end
}
