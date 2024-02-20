{
  description = "damarus NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.damaruNixOS = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
