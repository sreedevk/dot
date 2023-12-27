return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup()

    vim.keymap.set("n", "<Leader>fa", function() harpoon:list():append() end)
    vim.keymap.set("n", "<Leader>fl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<Leader>fo", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<Leader>fi", function() harpoon:list():next() end)
  end
}
