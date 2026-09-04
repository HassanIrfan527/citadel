{ config, pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      theme = "square_hud"; 

      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" "ironman" "pixels" "cyanide" "square_hud"];
        })
      ];
    };

    # Make sure kernel messages stay silent so the splash screen displays cleanly
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
