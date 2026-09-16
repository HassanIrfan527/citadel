{
  config,
  pkgs,
  lib,
  ...
}:

{
  # --- Graphics (Intel HD 530) ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # modern VA-API (iHD)
      intel-vaapi-driver
      libvdpau-va-gl
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      libva
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    MESA_GL_VERSION_OVERRIDE = "4.5";
  };

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642; # SteamOS value, helps many games
  };

  boot.kernelParams = [
    "i915.enable_guc=2" # or 3 depending on generation
  ];

  # --- Steam ---
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.steam-hardware.enable = true;

  # --- GameMode ---
  programs.gamemode = {
    enable = true;
    # settings = { ... };  # you can tune later if needed
  };

  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;
}
