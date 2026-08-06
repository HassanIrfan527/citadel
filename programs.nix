{ config, pkgs, ... }:

{
  programs = {
    niri.enable = true;
    zsh.enable = true;
    git.enable = true;
    tmux.enable = true;
    steam = {
	enable = true;
	package = pkgs.steam.override {
	extraArgs = "-cef-disable-gpu-compositing";
	};
    };
    direnv.enable = true;
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
    };
  };
}
