{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chicken
  ];
}
