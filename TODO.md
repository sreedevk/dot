# Neovim
- [ ] Alacritty Multi Key Sends Inside Neovim
    - Alacritty has an issue where inside neovim "backspace" character is sent multiple times 
    - fixed in: [8397](https://github.com/alacritty/alacritty/pull/8397) waiting for release
- [ ] Code Companion Plugin Read OPENAI_API_KEY from env rather than agenix file
    - CodeCompanion depends on $OPENAI_API_KEY env variable, move this config to nix to rely on agenix directly
- [ ] Kitty Existing Neovim After Opening "Overseer nvim" Puts Prompt at "execute:3u"
- [x] Neotree Buffers should be excuded from mksession!
    - Fixed using `auto_clean_after_session_restore` option in neo-tree
- [ ] flash nvim's range of search is limited to N lines before or after current line, expand this
