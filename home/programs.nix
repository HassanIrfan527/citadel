{ pkgs, ... }: {

  programs = {
    # Enable Home Manager to manage itself
    home-manager.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
