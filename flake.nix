{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mechsim = {
      url = "github:cjlangan/MechSim";
      flake = false;
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-graph = {
      url = "github:AlexAntonik/nix-graph";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      darkmatter-grub-theme,
      mechsim,
      silentSDDM,
      mangowm,
      nix-graph,
      ...
    }:
    {
      nixosConfigurations.citadel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          darkmatter-grub-theme.nixosModule
          home-manager.nixosModules.home-manager
          silentSDDM.nixosModules.default
          mangowm.nixosModules.mango

          ./configuration.nix
          ./noctalia.nix
        ];
      };
    };
}
