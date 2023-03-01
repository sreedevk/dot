local barbecue_ok, barbecue = pcall(require, "barbecue")
if not barbecue_ok then
  return
end

local helpers_ok, helpers = pcall(require, "helpers")
if not helpers_ok then
  return
end


barbecue.setup({
  create_autocmd = false,
  exclude_filetypes = { "neo-tree", "neo-tree-popup", "notify", "gitcommit", "toggleterm" }
})

helpers.create_augroups(
  {
    barbecue = {
      { "WinScrolled", "*", "silent! lua require('barbecue.ui').update()" }
    }
  }
)
