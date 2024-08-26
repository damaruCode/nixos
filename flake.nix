{
  description = "damarus NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.ace = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/ace/configuration.nix
        ./modules
      ];
    };
  };
}
