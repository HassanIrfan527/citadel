{ config, pkgs, ... }:

{
  programs = {
    nix-ld.enable = true;

    kdeconnect.enable = true;
    direnv.nix-direnv.enable = true;

    direnv.enable = true;
    niri.enable = true;
    zsh.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraArgs = "-cef-disable-gpu-compositing";
      };
    };
    gamemode.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };

}
