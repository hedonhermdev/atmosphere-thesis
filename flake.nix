{
  description = "A simple project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: let
    # System types to support.
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

    # Rust nightly version.
    nightlyVersion = "2022-11-06";
  in flake-utils.lib.eachSystem supportedSystems (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    my-python-packages = with pkgs.python3Packages; [
      pygments
    ];
  in {
    devShell = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        texlive.combined.scheme-full
        texlab
        python310Packages.pygments
      ];
    };
  });
}
