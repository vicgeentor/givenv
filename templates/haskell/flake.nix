{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { config, pkgs, ... }:
        {
          packages = rec {
            CHANGE_ME = pkgs.haskellPackages.developPackage { root = ./.; };
            default = CHANGE_ME;
          };

          devShells.default = pkgs.haskellPackages.shellFor {
            packages = _: [ config.packages.default ];
            nativeBuildInputs = with pkgs; [
              cabal-install
              ghc
              haskellPackages.cabal-fmt
              haskell-language-server
              hlint
            ];
          };
        };
    };
}
