{ config, pkgs, ... }:

{

  services = {
    flatpak.enable = true;
    timesyncd.enable = true;
    libinput.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin"; # most important fix
      };

      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
          CursorSize = "24";
        };
      };

      extraPackages = with pkgs; [
        bibata-cursors
      ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    openssh.enable = true;
    fwupd.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    keyd.enable = true;

    # Enable the GNOME Keyring service
    gnome.gnome-keyring.enable = true;

    resolved.enable = true;

    syncthing = {
      enable = true;
      user = "dweller";
      dataDir = "/mnt/personal/Ebooks & PDFs/Manga/";
      configDir = "/home/dweller/.config/syncthing";
      openDefaultPorts = true;
    };
  };

}
