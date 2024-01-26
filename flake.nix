{
  description = "Playing around with Mu-lang.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      muCompiler = pkgs.callPackage ./default.nix {};

      fibonacciSrc = pkgs.writeTextFile {
        name = "fibonacci";
        text = builtins.readFile ./fibonacci.mu;
      };
      fibonacci = pkgs.writeShellScript "fibonacci.sh" ''
        ${muCompiler}/bin/mu ${fibonacciSrc}
      '';
    in {
      packages = {
        inherit fibonacciSrc;
      };
      apps = {
        muCompiler = {
          type = "app";
          program = "${muCompiler}/bin/mu";
        };
        fibonacci = {
          type = "app";
          program = "${fibonacci}";
        };
      };
    });
}
