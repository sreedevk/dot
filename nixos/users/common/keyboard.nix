{ lib, pkgs, ... }: {
  home.keyboard = {
    layout = "us";
    options = [
      "ctrl:nocaps"
    ];
  };
}
