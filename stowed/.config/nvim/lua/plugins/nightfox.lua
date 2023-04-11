return {
  'EdenEast/nightfox.nvim',
  config = function()
    require('nightfox').setup({
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        }
      }
    })

    vim.cmd('colorscheme terafox')
  end
}
