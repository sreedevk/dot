{ ... }:
let
  themes = import ../themes.nix;
  theme = themes.zitchdog-pine;
in
{
  home.file = {
    ".config/ghostty/themes/zitchdog-grape" = {
      enable = true;
      text = ''
        palette = 0=${theme.color0}
        palette = 1=${theme.color1}
        palette = 2=${theme.color2}
        palette = 3=${theme.color3}
        palette = 4=${theme.color4}
        palette = 5=${theme.color5}
        palette = 6=${theme.color6}
        palette = 7=${theme.color7}
        palette = 8=${theme.color8}
        palette = 9=${theme.color9}
        palette = 10=${theme.color10}
        palette = 11=${theme.color11}
        palette = 12=${theme.color12}
        palette = 13=${theme.color13}
        palette = 14=${theme.color14}
        palette = 15=${theme.color15}

        background = ${theme.background}
        foreground = ${theme.foreground}
        cursor-color = ${theme.cursor}
        selection-background = ${theme.selection_background}
        selection-foreground = ${theme.selection_foreground}
      '';
    };
  };
}
