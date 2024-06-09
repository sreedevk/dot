# NixOS & Home Manager Configuration

## Home Manager (Re)build

```bash
$ home-manager switch --flake './nixos#${user}'
```

## NixOS Install (Re)build

```bash
$ sudo nixos-rebuild switch --flake './nixos' --upgrade
```

## Updating the flake

```bash
$ nix flake update './nixos'
```
