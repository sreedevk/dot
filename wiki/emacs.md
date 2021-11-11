## The Dot Project Wiki - Emacs Configuration

The dot project contains doom emacs configuration at `stowed/.doom.d` and also spacemacs configuration at `stowed/.spacemacs`.
The recommended way to use emacs using the dot project is by using [chemacs2](https://github.com/plexus/chemacs2).
chemacs2 allows you to install multiple flavors of emacs and switch between them at startup.

The `stowed/.emacs-profiles.el` file contains the profile configurations for chemacs2. The dot project 
configuration expects different emacs distributions / flavors to be installed in `~/.emacs-distros`.

the default emacs flavor can be set at `~/.emacs-profile`

custom flavors can be launched with `emacs --with-profile=<EMACS PROFILE OPTION>`

### Installing Doom Emacs

![](https://user-images.githubusercontent.com/36154121/141369711-0cf70be3-fd4e-4c52-8e58-d9e7be77d26e.png)

Some zsh functions & chemacs2 configurations in the dot project expect doom-emacs to be installed at `$HOME/.emacs-distros/doom-emacs`.
so you can install doom-emacs at the recommended location by cloning the repository at the location.

```bash
  $ git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs-distros/doom-emacs
```

if you've installed emacs at the recommended location, the doom bin path should automatically be appended to $PATH.
You complete the doom emacs installation by running:

```bash
  $ doom install
```

It should take you about 20 minutes.

Doom is the default emacs flavor for the dot project.

### Installing Spacemacs

![](https://user-images.githubusercontent.com/36154121/141370031-b43bbe2f-19aa-419b-bc19-536d120f8ce9.png)

spacemacs configuration in the dot project is pretty basic. you can modify the `~/.spacemacs` modify the spacemacs configuration.

```bash
  $ git clone https://github.com/syl20bnr/spacemacs ~/.emacs-distros/spacemacs
```

If You'd like to set spacemacs as the default emacs flavor, replace the contents of `~/.emacs-profile` with

```
  spacemacs
```

### Installing Custom Emacs Distros / Flavors

You can install any number of emacs distributions by cloning the distro repository to `~/.emacs-distros` & creating a 
corresponding entry in `~/.emacs-profiles.el`
