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

    # ── The Sanctuary — launcher backend ──
    # walker 2.x is a UI only; elephant is the provider process that actually
    # knows about desktop entries, the clipboard, the calculator and so on.
    # Without it walker opens and sits on "Waiting for elephant...".
    #
    # This module gives it a systemd *user* service bound to
    # graphical-session.target, so it starts and stops with the session rather
    # than living at boot. That resident process is the trade that buys the
    # launcher its instant open — see DESIGN-BRIEF.md §5.
    #
    elephant.enable = true;

    # TRIMMED ON PURPOSE, and the numbers are the reason. elephant's default
    # build enables all 25 providers, several of which are for other distros
    # entirely and just log an error and switch themselves off here
    # ("pacman: executable file not found", "apt-cache command not found").
    # Measured on this machine, resident:
    #
    #   all 25 providers          368.8 MB RSS   121.8 MB anonymous
    #   desktopapplications+calc   48.1 MB RSS    10.9 MB anonymous
    #
    # 122 MB of anonymous memory is roughly what the warm-kitty launcher was
    # rejected for; 11 MB is not worth arguing about. DESKTOP-PLAN.md §1.
    #
    # WHY calc IS HERE AND NOT JUST desktopapplications: nixpkgs bug. The
    # package's postInstall runs
    #   wrapProgram $out/bin/elephant \
    #     --prefix PATH : ${lib.makeBinPath runtimeDeps} \
    #     --set ELEPHANT_PROVIDER_DIR ...
    # and runtimeDeps is empty unless one of files/bluetooth/calc/clipboard is
    # enabled. With it empty the line becomes `--prefix PATH : ` which eats
    # the next flag, and the build dies in postInstall with "makeWrapper
    # doesn't understand the arg ELEPHANT_PROVIDER_DIR" — after compiling
    # fine. calc pulls libqalculate, which keeps runtimeDeps non-empty and
    # sidesteps it. It is also a calculator in the launcher, so no loss.
    #
    # To add a provider (elephant ships clipboard, files, websearch, symbols,
    # unicode, todo, playerctl, niriactions, nirisessions, windows, ...):
    # add it here, add it to [providers] in ~/.dotfiles/walker/walker/
    # config.toml, and add an item_<provider>.xml to the theme or it falls
    # back to walker's default two-line row. See DESIGN-BRIEF.md §5.
    elephant.package = pkgs.elephant.override {
      enabledProviders = [
        "desktopapplications"
        "calc"
      ];
    };

    syncthing = {
      enable = true;
      user = "dweller";
      dataDir = "/mnt/personal/Ebooks & PDFs/Manga/";
      configDir = "/home/dweller/.config/syncthing";
      openDefaultPorts = true;
    };
  };

}
