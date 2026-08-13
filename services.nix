{ config, pkgs, ... }:

{

  services = {
    flatpak.enable = true;
    timesyncd.enable = true;
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    tailscale.enable = true;
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

    adguardhome = {
      enable = true;
      openFirewall = false;
      settings = {
        dns = {
          bind_hosts = [ "127.0.0.1" ];
        };
      };
    };

    # By default, systemd-resolved binds to port 53. AdGuard needs that port to work.
    resolved.enable = false;
  };
}
