vim.keymap.set("n", "g0", function() require 'man'.show_toc() end, {
  buffer = true,
  desc = "Show man TOC",
  noremap = true,
})
