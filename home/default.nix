{ config, pkgs, ... }:

{
  imports = [
    ./theme.nix
    ./modules/git.nix
    ./modules/tmux.nix
  ];

  # User information
  home.username = "dweller";
  home.homeDirectory = "/home/dweller";

  home.stateVersion = "26.05";
  home.sessionVariables = {
    GTK_THEME = "Graphite-Dark";
  };

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}
