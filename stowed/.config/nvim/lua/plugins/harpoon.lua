return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    local harpoon = require("harpoon")

    harpoon.setup()

    vim.keymap.set("n", "<Leader>fa", function() harpoon:list():add() end)
    vim.keymap.set("n", "<Leader>fl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<M-o>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<M-i>", function() harpoon:list():next() end)
  end
}
