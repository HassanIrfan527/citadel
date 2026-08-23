{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
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
