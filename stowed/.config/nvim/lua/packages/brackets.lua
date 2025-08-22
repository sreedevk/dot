return {

  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    enabled = false,
    config = true,
    opts = {
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
        "snacks_picker_input",
        "scheme",
        "clojure",
        "dune",
        "fennel",
        "janet",
        "query",
        "racket",
        "scheme",
        "lisp"
      },
      disable_in_macro = true,
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,
      enable_check_bracket_line = true,
      enable_bracket_in_quote = true,
      enable_abbr = false,
      break_undo = true,
      check_ts = false,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false
    }
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    ft = {
      "clojure",
      "dune",
      "fennel",
      "janet",
      "query",
      "racket",
      "scheme",
      "lisp",
    },
  },

  {
    "gpanders/nvim-parinfer",
    ft = {
      "clojure",
      "dune",
      "fennel",
      "janet",
      "query",
      "racket",
      "scheme",
      "lisp"
    },
    config = function()
      vim.g.parinfer_filetypes = {
        "clojure",
        "dune",
        "fennel",
        "janet",
        "query",
        "racket",
        "scheme",
        "lisp"
      }
    end,
  },

}
