# NeoVim
- [ ] Code Companion Plugin Read OPENAI_API_KEY from env rather than agenix file
    - CodeCompanion depends on $OPENAI_API_KEY env variable, move this config to nix to rely on agenix directly
- [x] Kitty Existing Neovim After Opening "Overseer nvim" Puts Prompt at "execute:3u"
    - This was the `vicmd` mode in zsh. 
    - I resolved this issue by disabling the keybinding in zshrc
    - Fixed in Commit `6129c42a12ae09b2222933ba2a12f217f0255b47`
- [x] Neotree Buffers should be excuded from mksession!
    - Fixed using `auto_clean_after_session_restore` option in neo-tree
- [ ] flash nvim's range of search is limited to N lines before or after current line, expand this
- [x] Neovim Zitchdog colorscheme causes issues with diffview inside neogit
    - Issue raised [here](https://github.com/theamallalgi/zitchdog/issues/2)
    - temporarily using tokyonight
    - Fixed in Commit [85caa7c094d6481b985a8280d2f77ab7a45c44ec](https://github.com/theamallalgi/zitchdog/commit/85caa7c094d6481b985a8280d2f77ab7a45c44ec)
- [x] Treewalker plugin will fail on empty buffers verbosely. Prevent it from loading if treesitter is not available for buffer
    - Fixed by lazy loading plugin on C-j & C-k
- [ ] in Neovim, add a custom dial.nvim set to alternate between `[ '*', '!']` for hledger transaction status
- [ ] Build / Find a Hledger Treesitter Library
- [ ] Add nvim-lint

# Hyprland
- [ ] Screensharing does not work. Options Tried:
    - Followed the guide [here](https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580)
    - Set the bitdepth for monitors
    - Using hyprland-git
    - [Troubleshooting Checklist](https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist)

# Ghostty
- [ ] Unable to make write_scrollback_buffer option work with `open` param
    - Tried to set `text/plain` mime type xdg application to neovim.desktop
    - Even if this works, I don't have a way to load an arbitrary neovim config specifically for scrollback.

# Tmux
- [x] restore ctrl+b plus [  to enter scrollback mode in tmux

# Wayland / Xorg
- [ ] setup a global wayland = true option for nix users to switch options everywhere

# Alacritty
- [x] Alacritty Multi Key Sends Inside Neovim
    - Alacritty has an issue where inside neovim "backspace" character is sent multiple times 
    - fixed in: [8397](https://github.com/alacritty/alacritty/pull/8397) waiting for release
    - Alacritty disabled until 0.15 is available in nixpkgs
    - Fixed by creating a custom 0.15 build from head of master
