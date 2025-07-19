{
  description = "The Pebble development documentation, hosted at developer.rebble.io";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          name = "developer.rebble.io-devshell";
          packages = with pkgs; [
            bundler
            nixd
            nixfmt-rfc-style
            nodejs
            ruby
            python3
            zlib
          ];
        };
      }
    );
}
