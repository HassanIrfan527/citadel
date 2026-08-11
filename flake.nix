{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qylock.url = "github:Darkkal44/qylock";

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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      qylock,
      home-manager,
      darkmatter-grub-theme,
      mechsim,
      ...
    }:
    {
      nixosConfigurations.citadel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          qylock.nixosModules.default
          darkmatter-grub-theme.nixosModule
          home-manager.nixosModules.home-manager

          ./configuration.nix
          ./noctalia.nix
        ];
      };
    };
}
