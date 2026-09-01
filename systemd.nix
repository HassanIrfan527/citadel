{ config, pkgs,lib, ... }:
{
  systemd = {
    services.syncthing.wantedBy = lib.mkForce [ ];
  };
}
