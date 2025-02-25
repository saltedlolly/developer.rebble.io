{
  description = "The Pebble development documentation, hosted at developer.rebble.io";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # Ruby 2.2 was removed from Nixpkgs in commit e8194c2. The commit specified is the parent of that commit (ie. the
    # last commit that contains Ruby 2.2),
    nixpkgs-ruby = {
      url = "github:NixOS/nixpkgs/c80adf5f72b8ea4ebd83d04bfbfbdc4cebbeed6f";
      flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-ruby,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # The checkout of Nixpkgs predates flakes - we need to import it the old-school way
        pkgs-ruby = import nixpkgs-ruby { inherit system; };
      in
      {
        devShell = pkgs-ruby.mkShell {
          name = "developer.rebble.io-devshell";
          nativeBuildInputs =
            with pkgs;
            [
              nil
              nixfmt-rfc-style
            ]
            ++ (with pkgs-ruby; [
              (bundler.override { ruby = ruby_2_2; })
              nodejs
              ruby_2_2
              python2
              zlib
            ]);
        };
      }
    );
}
