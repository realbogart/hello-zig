{
  description = "hello-zig";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dependencies = with pkgs; [ zig raylib libGL ];
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "hello-zig";
          src = ./.;
          buildInputs = dependencies;
          buildPhase = ''
            zig build
          '';
        };
        devShells.default = pkgs.mkShell {
          buildInputs = dependencies;
          shellHook = ''
            export RAYLIB_PATH_INCLUDE=${pkgs.raylib}/include
            export RAYLIB_PATH_LIB=${pkgs.raylib}/lib
            export OPENGL_PATH_LIB=${pkgs.libGL}/lib
            echo "RAYLIB_PATH_INCLUDE=$RAYLIB_PATH_INCLUDE"
            echo "RAYLIB_PATH_LIB=$RAYLIB_PATH_LIB"
            echo "OPENGL_PATH_LIB=$OPENGL_PATH_LIB"
          '';
        };
      });
}
