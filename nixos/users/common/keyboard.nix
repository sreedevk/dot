{ lib, pkgs, ... }: {
  home.keyboard = {
    layout = "us,apl";
    variant = ",dyalog";
    options = [
      "grp:alt_shift_toggle"
      "ctrl:nocaps"
      "compose:ralt"
    ];
  };
}
