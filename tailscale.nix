{ config, pkgs, ... }:

{
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--accept-dns=true" ];

  # Allow Tailscale traffic through the NixOS firewall
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
