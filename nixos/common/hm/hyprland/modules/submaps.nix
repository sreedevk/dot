{ ... }:
{
  home.file = {
    ".config/hypr/submaps.conf" = {
      enable = true;
      text = ''
        bind = SUPER, R, submap, resize
        submap = resize
        binde = , right, resizeactive, 10 0
        binde = , left, resizeactive, -10 0
        binde = , up, resizeactive, 0 -10
        binde = , down, resizeactive, 0 10
        binde = , L, resizeactive, 10 0
        binde = , H, resizeactive, -10 0
        binde = , K, resizeactive, 0 -10
        binde = , J, resizeactive, 0 10
        bind = , escape, submap, reset 
        submap = reset
      '';
    };
  };
}
