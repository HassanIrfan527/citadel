{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./theme.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./programs.nix
  ];

  # User information
  home.username = "dweller";
  home.homeDirectory = "/home/dweller";

  home.stateVersion = "26.05";
  home.sessionVariables = {
    GTK_THEME = "Graphite-Dark";

  };
  home.packages = with pkgs; [
    ibm-plex
  ];

  fonts.fontconfig.enable = true;
}
