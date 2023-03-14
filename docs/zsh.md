# ZShell
Lightweight but functional ZShell setup with Starship prompt & Antibody Plugin Manager

## Dependencies
- [ZShell >=v5.9](https://www.zsh.org/)
- [Anitbody Plugin Manager](https://getantibody.github.io/)
- [Starship Prompt](https://starship.rs/)
- [Atuin](https://atuin.sh/)
- [Exa](https://the.exa.website/)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)

## Guide
The zsh config on the dot project has been split into multiple files for organization

|--------------------|-------------------------------------------------|
| File               | Description                                     |
|--------------------|-------------------------------------------------|
| `~/.zshrc`         | contains general variable declarations and opts |
| `~/.zsh/vi`        | vim keybindings for zsh                         |
| `~/.zsh/fzf`       | zsh fzf opts                                    |
| `~/.zsh/aliases`   | zsh aliases                                     |
| `~/.zsh/plugins`   | plugins (used by antibody)                      |
| `~/.zsh/autoloads` | zsh autoloads for atuin, zoxide, asdf-vm etc    |
| `~/.zsh/functions` | zsh utility functions                           |
|--------------------|-------------------------------------------------|

## Installation
```bash
  # Remove Existing Config!!
  rm -rf ~/.zsh ~/.zshrc

  # Link New Configs
  ln -s ~/.dot/stowed/.zshrc ~/.zshrc
  ln -s ~/.dot/stowed/.zsh ~/.zsh
```
## Installing ZShell Plugins
On first startup, run `antibody-compile` to download and compile zsh plugins
