{ config, pkgs, ... }:

{
  # 1. Include hardware settings (automatically generated during installation)
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./programs.nix
    ./environment.nix
    ./users.nix
    ./security.nix
    ./qylock.nix
    ./mechsim.nix
    ./systemd.nix
    ./tailscale.nix
    ./freshrss.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    useUserPackages = true;
    users.dweller = import ./home/default.nix;
  };

  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  # Add nix garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024; # MB (8 GiB)
    }
  ];
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;

      enable32Bit = true;
    };
    cpu.intel.updateMicrocode = true;
  };
  # Bootloader setup (UEFI)
  boot.loader.grub = {

    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;

    darkmatter-theme = {
      enable = true;
      style = "nixos";
      icon = "color";
      resolution = "1080p";
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # 3. Hostname and Network
  networking = {
    hostName = "citadel";
    networkmanager = {
      enable = true;
      dns = "none";
    };

    stevenblack = {
      enable = true;
      block = [
        "fakenews"
        "gambling"
        "porn"
      ];
    };

    firewall = {
      enable = true;
      checkReversePath = false; # Prevents dropped packets when routing traffic through the VPN
      allowedUDPPorts = [ 1194 ];
      allowedTCPPorts = [ 443 ];
    };

    nameservers = [ "127.0.0.1" ];
  };

  # 4. Time zone and Locale
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # 5. User Account

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.containers.registries.settings = {
    registry = [
      {
        location = "docker.io";
      }
    ];
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "dweller"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://noctalia.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Enable Nix's Auto-optimization
  nix.settings.auto-optimise-store = true;
}
