{
  description = "Flake for ComfyUI NixOS container with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos-host = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/container-host.nix
        home-manager.nixosModules.home-manager
      ];

      specialArgs = {
        inherit home-manager;
      };
    };
  };
}

