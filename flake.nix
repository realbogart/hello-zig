{
  description = "hello-zig";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        dependencies = with pkgs; [ zig ];
      in { devShells.default = pkgs.mkShell { buildInputs = dependencies; }; });
}
