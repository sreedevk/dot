## The Dot Project

This is a collection of my dot configuration files.

  Alacritty + Tmux + Glances   |  Neovim
![](https://user-images.githubusercontent.com/36154121/143617161-58ff0acd-b755-4409-8b92-6b739d343252.png) | ![](https://user-images.githubusercontent.com/36154121/141366992-83190c45-d918-47fa-9d22-61eb8f40e008.png)


  Doom Emacs               |  Spacemacs
:-------------------------:|:-------------------------:
 ![](https://user-images.githubusercontent.com/36154121/141369711-0cf70be3-fd4e-4c52-8e58-d9e7be77d26e.png)| ![](https://user-images.githubusercontent.com/36154121/141370031-b43bbe2f-19aa-419b-bc19-536d120f8ce9.png)

### Installation

#### Using The Dot Project script (Recommended)

The Dot Project script for installation is only available for arch linux at the moment.
Please use the manual method until the script becomes available for other distros.

NOTE: DO NOT RUN THE DOT PROJECT SCRIPT WITH SUDO. YOU WILL BE PROMPTED FOR SU PERMISSIONS IF REQUIRED. 

##### Arch Linux

1. Clone the repository

```bash
  $ git clone https://github.com/sreedevk/dot ~/.dot
```

2. Run the Dot Project Installer

```bash
  $ ~/.dot/installer/arch/base.sh
```

#### Manual Installation

1. Clone the repository

```bash
  $ git clone https://github.com/sreedevk/dot ~/.dot
```

2. Run Stow

```bash
  $ cd ~/.dot && stow stowed
```

### Updating

1. cd into the `~/.dot` directory

```bash
  $ cd ~/.dot && git pull origin master
```

2. Restow

```bash
  $ stow -R stowed
```

NOTE: Dependency errors after manually installing are to be expected.
The dependencies will have to be installed manually too.

### Troubleshooting

When using GNU stow, please ensure that you have removed all current configurations from your system. Stow will not overwrite existing files.

### Documentation

Checkout the project documentation & application specific configuration [here](https://github.com/sreedevk/dot/blob/master/wiki/).


### Roadmap
1. Implement `luks-good` LUKS helper script functions
