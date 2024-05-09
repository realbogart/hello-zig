{
  description = "hello-zig";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dependencies = with pkgs; [ zig raylib libGL ];
        env = ''
          export RAYLIB_PATH_INCLUDE=${pkgs.raylib}/include
          export RAYLIB_PATH_LIB=${pkgs.raylib}/lib
          export OPENGL_PATH_LIB=${pkgs.libGL}/lib
          echo "RAYLIB_PATH_INCLUDE=$RAYLIB_PATH_INCLUDE"
          echo "RAYLIB_PATH_LIB=$RAYLIB_PATH_LIB"
          echo "OPENGL_PATH_LIB=$OPENGL_PATH_LIB"
        '';
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "hello-zig";
          src = ./.;
          buildInputs = dependencies;
          preConfigure = env;
          dontUnpack = true;
          buildPhase = ''
            cd $src
            export HOME=$(mktemp -d)
            zig build --prefix $out --cache-dir $HOME/zig-cache
          '';
        };
        devShells.default = pkgs.mkShell {
          buildInputs = dependencies;
          shellHook = env;
        };
      });
}
