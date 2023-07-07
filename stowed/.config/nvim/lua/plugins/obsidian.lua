return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre /home/sreedev/Data/notebook/obsidian/**.md" },
  cmd = {
    "ObsidianBacklinks",
    "ObsidianToday",
    "ObsidianYesterday",
    "ObsidianOpen",
    "ObsidianNew",
    "ObsidianSearch",
    "ObsidianQuickSwitch",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianFollowLink",
    "ObsidianTemplate",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "godlygeek/tabular",
    "preservim/vim-markdown",
  },
  opts = {
    dir          = "~/Data/notebook/obsidian",  -- no need to call 'vim.fn.expand' here
    notes_subdir = "notes",
    log_level    = vim.log.levels.INFO,
    daily_notes = {
      folder = "notes/dailies",
      date_format = "%Y-%m-%d"
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
      new_notes_location = "current_dir"
    },

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    disable_frontmatter = false,
    note_frontmatter_func = function(note)
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    follow_url_func = function(url)
      -- vim.fn.jobstart({"open", url})  -- Mac OS
      vim.fn.jobstart({"xdg-open", url})  -- linux
    end,
    use_advanced_uri = true,
    open_app_foreground = false,
    finder = "telescope.nvim",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    vim.keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, { noremap = false, expr = true })
  end,
}
