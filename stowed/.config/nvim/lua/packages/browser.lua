return {
  {
    "voldikss/vim-browser-search",
    lazy = true,
    cmd = { 'BrowserSearch' },
    init = function()
      vim.g.browser_search_default_engine = "duckduckgo"
    end,
    keys = {
      { "<Leader>se", "<Plug>SearchNormal", noremap = true, desc = "Send to Search Engine" },
      { "<Leader>se", "<Plug>SearchVisual", noremap = true, desc = "Send to Search Engine", mode = { "v" } }
    }
  }
}
