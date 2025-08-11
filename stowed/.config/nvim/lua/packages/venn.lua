return {
  'jbyuki/venn.nvim',
  lazy = true,
  keys = {
    {
      "<Leader>tv",
      function()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("v", "f", ":VBox<CR>", { noremap = true, buffer = true })
        else
          vim.cmd [[setlocal ve=]]
          vim.cmd [[mapclear <buffer>]]
          vim.b.venn_enabled = nil
        end
      end,
      desc = "Toggle Venn",
      noremap = true,
    }
  }
}
