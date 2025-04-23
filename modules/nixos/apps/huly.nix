{ pkgs, ... }: let
  pname = "huly";
  version = "0.6.490";

  src = pkgs.fetchurl {
    url = "https://dist.huly.io/Huly-linux-0.6.490.AppImage";
    hash = "sha256-b86d1c2e3aec1a83426a4f323786c31aaec7e8fb27273174c744e48f8bae6dff=";
  };
  appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
in
    pkgs.appimageTools.wrapType2 {
      inherit pname version src;
      pkgs = pkgs;
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
        cp -r ${appimageContents}/usr/share/icons $out/share

        # unless linked, the binary is placed in $out/bin/cursor-someVersion
        # ln -s $out/bin/${pname}-${version} $out/bin/${pname}
      '';

      extraBwrapArgs = [
        "--bind-try /etc/nixos/ /etc/nixos/"
      ];

      # vscode likes to kill the parent so that the
      # gui application isn't attached to the terminal session
      dieWithParent = false;

      extraPkgs = pkgs: with pkgs; [
        unzip
        autoPatchelfHook
        asar
        # override doesn't preserve splicing https://github.com/NixOS/nixpkgs/issues/132651
        (buildPackages.wrapGAppsHook.override {inherit (buildPackages) makeWrapper;})
      ];
    }
