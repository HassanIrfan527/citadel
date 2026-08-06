{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qylock.url = "github:Darkkal44/qylock";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      qylock,
      ...
    }:
    {
      nixosConfigurations.citadel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          qylock.nixosModules.default

          ./configuration.nix
          ./noctalia.nix
        ];
      };
    };
}
