{ config, pkgs, ... }:

{

  security = {
    sudo.wheelNeedsPassword = true;
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.sddm.enableGnomeKeyring = true;
    # Without this swaylock accepts the password and then refuses to unlock —
    # it has no PAM stack of its own on NixOS.
    pam.services.swaylock = { };
  };

}
