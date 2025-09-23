{
  pkgs,
  config,
  opts,
  ...
}:
let
  hyprconf = import ../opts.nix { inherit pkgs config opts; };
  utils = import ../utils.nix;
in
{
  home.file = {
    ".config/hypr/inputs.conf" = {
      enable = true;
      text = builtins.concatStringsSep "\n" (
        pkgs.lib.lists.flatten (utils.genNested "input" hyprconf.inputs)
      );
    };
    ".config/hypr/gestures.conf" = {
      enable = true;
      text =
        let
          mkOptional = x: if builtins.isNull (x) then [ ] else [ x ];
          genGestures =
            gestures:
            let
              mkGesture =
                gesture:
                let
                  key = "gesture";
                  value = builtins.concatStringsSep "," (
                    builtins.concatLists [
                      [
                        gesture.fingers
                        gesture.direction
                      ]
                      (mkOptional gesture.modifier)
                      (mkOptional gesture.scale)
                      [
                        gesture.action
                        gesture.args
                      ]
                    ]
                  );
                in
                "${key} = ${value}";
            in
            builtins.concatStringsSep "\n" (builtins.map mkGesture gestures);
        in
        genGestures hyprconf.gestures;
    };
  };
}
