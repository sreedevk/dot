# NeoVim
- [ ] Alacritty Multi Key Sends Inside Neovim
    - Alacritty has an issue where inside neovim "backspace" character is sent multiple times 
    - fixed in: [8397](https://github.com/alacritty/alacritty/pull/8397) waiting for release
- [-] Code Companion Plugin Read OPENAI_API_KEY from env rather than agenix file
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
- [ ] Treewalker plugin will fail on empty buffers verbosely. Prevent it from loading if treesitter is not available for buffer

# Hyprland
- [ ] Screensharing does not work. Options Tried:
    - Followed the guide [here](https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580)
    - Set the bitdepth for monitors
    - Using hyprland-git
    - [Troubleshooting Checklist](https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist)
