-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/sreedev/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/sreedev/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/sreedev/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/sreedev/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/sreedev/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["ayu-vim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/ayu-vim",
    url = "https://github.com/ayu-theme/ayu-vim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["gundo.vim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/gundo.vim",
    url = "https://github.com/sjl/gundo.vim"
  },
  hop = {
    config = { "\27LJ\1\2U\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/hop",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  nerdTree = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/nerdTree",
    url = "https://github.com/scrooloose/nerdTree"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/nvim-luapad",
    url = "https://github.com/rafcamlet/nvim-luapad"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["octo.nvim"] = {
    config = { "\27LJ\1\0022\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight-vim"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/tokyonight-vim",
    url = "https://github.com/ghifarit53/tokyonight-vim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-rails"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/vim-rails",
    url = "https://github.com/tpope/vim-rails"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/sreedev/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\1\0022\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Config for: hop
time([[Config for hop]], true)
try_loadstring("\27LJ\1\2U\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop")
time([[Config for hop]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
