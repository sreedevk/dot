{ pkgs, ... }:
let
  nixGLSource = builtins.fetchTarball {
    url = "https://github.com/guibou/nixGL/archive/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a.tar.gz";
    sha256 = "1crnbv3mdx83xjwl2j63rwwl9qfgi2f1lr53zzjlby5lh50xjz4n";
  };

  nixGLNvidia = (pkgs.callPackage "${nixGLSource}/nixGL.nix" { }).auto.nixGLNvidia;

  # SRC: https://git.jakstys.lt/motiejus/config/commit/9f61b9a378f28eb72da051fdaa55ec972cab1057
  mkWrapped = wrap: orig-pkg: execName:
    pkgs.makeOverridable
      (
        attrs:
        let
          pkg = orig-pkg.override attrs;
          outs = pkg.meta.outputsToInstall;
          paths = pkgs.lib.attrsets.attrVals outs pkg;
          nonTrivialOuts = pkgs.lib.lists.remove "out" outs;
          metaAttributes =
            pkgs.lib.attrsets.getAttrs
              (
                [
                  "name"
                  "pname"
                  "version"
                  "meta"
                ]
                ++ nonTrivialOuts
              )
              pkg;
        in
        pkgs.symlinkJoin (
          {
            inherit paths;
            nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
            postBuild = ''
              mv $out/bin/${execName} $out/bin/.${execName}-mkWrapped-original
              makeWrapper ${wrap}/bin/${wrap.name} $out/bin/${execName} --add-flags $out/bin/.${execName}-mkWrapped-original
            '';
          }
          // metaAttributes
        )
      )
      { };
in
{
  nixGLWrapped = mkWrapped nixGLNvidia;
}
