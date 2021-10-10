# Emacs Configuration / Setup

## Introduction

My Emacs configuration is close to stock doom emacs with minor modifications by default. 
This configuration uses [chemacs2](https://github.com/plexus/chemacs2) to switch between multiple
flavors of emacs.

By default, my [.emacs-profiles](https://github.com/sreedevk/dot/blob/master/.emacs-profiles.el) file contains the following configurations:

1. `doomacs`   - Basically Doom Emacs with my custom `~/.doom.d/` directory configurations [DEFAULT]
2. `customacs` - My basics from scratch emacs config with just Evil plugin installed.
3. `spacemacs` - Stock Spacemacs Configuration


you can switch between the profiles just using the `--with-profile=` option while starting emacs.

## Doom Emacs

### Getting Started

Since doom is the default profile for emacs in the dot project, you don't need to pass in any options.
Opening emacs with no options will boot up doom.

```sh
  emacs
```

### Installation

Before starting up doom emacs for the first time, you will have to install doom using the `doom/install` command as follows:

```sh
  ~/.doomacs.d/bin/doom install
```

This is a time consuming process.

### Updates & Configuration

All of your doom configurations need to be stored in `~/.doom.d/` folder.
you can run `doom sync` after making any changes to the doom config as follows:

```sh
  ~/.doomacs.d/bin/doom sync
```


### Caveats

Please note that you may have to re-install doom if you restow your clone of the dot project.

## Spacemacs
The Spacemacs installation is just the stock version. No customizations have been made by the dot project.

### Getting Started
```sh
  emacs --with-profile=spacemacs
```

### Installation
The installation is automatic with spacemacs. You do not need to run custom commands in order to sync / update spacemacs.

### Updates & Configuration
All modifications to your configuration needs to be made in the `~/.spacemacs.d` directory.

### Caveats
Restowing the dotfiles using GNU stow will result in removal of all installed packages. Spacemacs will redownload & install the packages


## Customacs
Customacs is a simple `init.el` file that loads the `config.org` literate emacs config.

### Getting Started
```sh
  emacs --with-profile=customacs
```

### Installation
The Customacs configuration only uses the Evil package & Doom Themes package. The packages are installed automatically when you start
emacs with the customacs profile for the first time.

### Updates & Configuration
All your customization and changes can be made in the `~/.customacs.d` directory. The `init.el` file is the entry point.
