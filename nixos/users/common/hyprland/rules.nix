{ pkgs, ... }:
let
in
{
  home.file = {
    ".config/hypr/rules.conf" = {
      enable = true;
      text = ''
        workspace = 1, monitor:desc:LG Electronics LG Ultra HD 0x00073F78, default:true
        workspace = 2, monitor:desc:LG Electronics LG Ultra HD 0x00073F78, default:true
        workspace = 3, monitor:desc:LG Electronics LG Ultra HD 0x00073F78, default:true
        workspace = 4, monitor:desc:AU Optronics 0xF99A, default:true
        workspace = 5, monitor:desc:XEC ES-24X3A 0x00000022, default:true
        workspace = 6, monitor:desc:XEC ES-24X3A 0x00000022, default:true
        workspace = 7, monitor:desc:XEC ES-24X3A 0x00000022, default:true

        windowrule = center, title:^(Open File)(.*)$
        windowrule = center, title:^(Select a File)(.*)$
        windowrule = center, title:^(Choose wallpaper)(.*)$
        windowrule = center, title:^(File Upload)(.*)$
        windowrule = center, title:^(Library)(.*)$
        windowrule = center, title:^(Open Folder)(.*)$
        windowrule = center, title:^(Save As)(.*)$
        windowrule = float, ^(blueberry.py)$
        windowrule = float, ^(guifetch)$ # FlafyDev/guifetch
        windowrule = float, ^(steam)$
        windowrule = float,title:^(Open File)(.*)$
        windowrule = float,title:^(Select a File)(.*)$
        windowrule = float,title:^(Choose wallpaper)(.*)$
        windowrule = float,title:^(Open Folder)(.*)$
        windowrule = float,title:^(Save As)(.*)$
        windowrule = float,title:^(Library)(.*)$
        windowrule = float,title:^(File Upload)(.*)$
        windowrule = immediate,.*\.exe
        
        windowrulev2 = float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = tile, class:(dev.warp.Warp)
        windowrulev2 = keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = move 73% 72%,title:^(Picture(-| )in(-| )[Pp]icture)$ 
        windowrulev2 = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = float, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = pin, title:^(Picture(-| )in(-| )[Pp]icture)$
        windowrulev2 = immediate,class:(steam_app)
        windowrulev2 = noshadow,floating:0

        layerrule = xray 1, .*
        layerrule = noanim, walker
        layerrule = noanim, selection
        layerrule = noanim, overview
        layerrule = noanim, anyrun
        layerrule = noanim, indicator.*
        layerrule = noanim, osk
        layerrule = noanim, hyprpicker
        layerrule = blur, shell:*
        layerrule = ignorealpha 0.6, shell:*
        layerrule = noanim, noanim
        layerrule = blur, gtk-layer-shell
        layerrule = ignorezero, gtk-layer-shell
        layerrule = blur, launcher
        layerrule = ignorealpha 0.5, launcher
        layerrule = blur, notifications
        layerrule = ignorealpha 0.69, notifications
        layerrule = animation slide left, sideleft.*
        layerrule = animation slide right, sideright.*
        layerrule = blur, session
        layerrule = blur, bar
        layerrule = ignorealpha 0.6, bar
        layerrule = blur, corner.*
        layerrule = ignorealpha 0.6, corner.*
        layerrule = blur, dock
        layerrule = ignorealpha 0.6, dock
        layerrule = blur, indicator.*
        layerrule = ignorealpha 0.6, indicator.*
        layerrule = blur, overview
        layerrule = ignorealpha 0.6, overview
        layerrule = blur, cheatsheet
        layerrule = ignorealpha 0.6, cheatsheet
        layerrule = blur, sideright
        layerrule = ignorealpha 0.6, sideright
        layerrule = blur, sideleft
        layerrule = ignorealpha 0.6, sideleft
        layerrule = blur, indicator*
        layerrule = ignorealpha 0.6, indicator*
        layerrule = blur, osk
        layerrule = ignorealpha 0.6, osk
      '';
    };
  };
}
