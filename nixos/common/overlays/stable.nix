{ inputs, ... }:
_: prev: {
  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system})
    jiratui
    imager
    iwd
    beets
    ;

  inherit (inputs.stablepkgs.legacyPackages.${prev.stdenv.hostPlatform.system}.python313Packages)
    autodocsumm
    sphinx
    sphinx-toolbox
    sphinx-prompt
    poetry-core
    cherrypy
    ;
}
