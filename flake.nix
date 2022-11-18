{

  description = "The story of Operaland told through Emacs Org Files";
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        fonts = pkgs.makeFontsConf { fontDirectories = [ pkgs.dejavu_fonts ]; };
        #pkgs = import nixpkgs { inherit system; };
      in {
        defaultPackage = pkgs.stdenv.mkDerivation {
          name = "Operaland";
          src = ./.;
          buildInputs = with pkgs; [ ];
          #phases = ["unpackPhase" "buildPhase"];
          #buildPhase = '''';
        };
        devShell = pkgs.mkShell {
          packages = with pkgs; [ nodePackages.vscode-html-languageserver-bin ];
        };
      });
}
