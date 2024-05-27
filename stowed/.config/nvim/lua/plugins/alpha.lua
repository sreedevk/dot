return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  event = "BufWinEnter",
  config = function()
    local header = {
      type = "text",
      val = {
        '',
        '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ',
        '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
        '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ',
        '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
        '          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
        '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
        '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
        ' ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
        ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ',
        '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
        '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
        '           N E O V I M             ',
        '',
      },
      opts = {
        position = "center",
        hl = "AlphaAscii"
      }
    }

    local date = os.date("%A, %d %B %Y")
    local title = {
      type = "text",
      val = "Today is " .. date,
      opts = {
        position = "center",
        hl = "AlphaEmphasis"
      }
    }

    local function button(sc, txt, keybind)
      local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

      local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 0,
        width = 47,
        align_shortcut = "right",
        hl_shortcut = "AlphaShortcuts",
        hl = "AlphaHeader",
      }
      if keybind then
        opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
      end

      return {
        type = "button",
        val = txt,
        on_press = function()
          local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
          vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts,
      }
    end

    local buttons = {
      type = "group",
      val = {
        button("e", "New File", ":enew<cr>"),
        button("z", "Zoxide", ":Zi<CR>"),
        button("l", "Last Session", "<cmd>lua require('persistence').load({last=true})<cr>"),
        button("f", "Find Files", ":Telescope find_files<CR>"),
        button("/", "Live Grep", ":Telescope live_grep<CR>"),
        button("p", "Lazy Dashboard", ":Lazy show<CR>"),
        button("q", "Quit Neovim", ":q<CR>"),
      },
      opts = {
        spacing = 0,
        hl = "AlphaButtons"
      },
    }

    local vim_ver = vim.version()
    vim_ver = 'Neovim ' .. vim_ver.major .. '.' .. vim_ver.minor .. '.' .. vim_ver.patch

    local footer = {
      type = "text",
      val = vim_ver,
      opts = {
        position = "center",
        hl = "AlphaFooter"
      }
    }

    local section = {
      header = header,
      buttons = buttons,
      heading = title,
      footer = footer
    }

    local opts = {
      layout = {
        { type = "padding", val = 1 },
        section.header,
        { type = "padding", val = 1 },
        section.heading,
        { type = "padding", val = 1 },
        section.buttons,
        { type = "padding", val = 1 },
        section.footer,
        { type = "padding", val = 1 },
      },
      opts = { margin = 44 },
    }

    require("alpha").setup(opts)
  end
}
