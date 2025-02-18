{
  description = "A customizable and extensible shell";

  inputs = {
    nixpkgs.url = "nixpkgs/23.11";
  };

  outputs = { nixpkgs, self }: let
    genSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: {
      default = pkgs.${system}.callPackage ./nix {};
    });

    homeManagerModules.default = import ./nix/hm-module.nix self;
  };
}
