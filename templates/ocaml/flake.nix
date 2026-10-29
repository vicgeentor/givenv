{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem =
        { pkgs, ... }:
        {
          packages.default = pkgs.buildDunePackage {
            pname = "CHANGE_ME";
            version = "0.0.1";

            src = ./.;
          };
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              ocaml
              (pkgs.writeShellScriptBin "dbw" ''
                dune build --watch
                dune clean
              '')
              (with pkgs.ocamlPackages; [
                ocaml-lsp
                ocamlformat
                dune_3
                findlib
              ])
            ];
          };
        };
    };
}
