{
  description = "damarus NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:damaruCode/nixvim";
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      nixvim,
      ...
    }@inputs:
    {
      nixosConfigurations.ace = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/ace/configuration.nix
          ./modules
        ];
      };

      nixosConfigurations.tuf = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "25.05";
            wsl.enable = true;
          }
          ./hosts/tuf/configuration.nix
          ./modules
        ];
      };
    };
}
