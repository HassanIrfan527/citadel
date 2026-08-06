{ config, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];

  # User information
  home.username = "dweller";
  home.homeDirectory = "/home/dweller";

  home.stateVersion = "26.05";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}
