{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-lib.follows = "flake-parts/nixpkgs-lib";

    nixpkgs.url = "github:NixOS/nixpkgs/25.11";

    flake-module = {
      url = ./flake-module.nix;
      flake = false;
    };

    packsquash.url = "github:MaxTheMooshroom/packsquash-nix";
    packsquash.inputs = {
      flake-parts.follows = "flake-parts";
      nixpkgs-lib.follows = "nixpkgs-lib";
      nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs-lib, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs-lib.lib.systems.flakeExposed;

      imports = [ (import inputs.flake-module inputs) ];
    };
}
