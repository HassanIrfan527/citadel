{ pkgs, inputs, ... }:

let
  mechsim-pkg = pkgs.stdenv.mkDerivation {
    pname = "mechsim";
    version = "1.1.0";

    src = inputs.mechsim;
    makeFlags = [ "PREFIX=$(out)" ];

    nativeBuildInputs = [
      pkgs.pkg-config
    ];

    # C libraries needed for linking
    buildInputs = [
      pkgs.json_c
      pkgs.libpulseaudio
      pkgs.libsndfile
      pkgs.libevdev
      pkgs.libinput
      pkgs.systemd # Provides libudev
    ];

    postPatch = ''
      # 1. Hardcode the Nix store path into config.h just in case the Makefile drops it
      sed -i "s|#define PACKAGE_PREFIX \"/usr\"|#define PACKAGE_PREFIX \"$out\"|g" config.h

      # 2. Bypass the ensure_sudo_access() check entirely
      find . -type f -name "*.c" -exec sed -i 's/if (!ensure_sudo_access())/if (0)/g' {} +

      # 3. Strip out the sudo wrapper and execute get_key_presses directly
      find . -type f -name "*.c" -exec sed -i 's/execl(sudo_path, "sudo", "-n", get_key_presses_path, (char \*)NULL);/execl(get_key_presses_path, "get_key_presses", (char \*)NULL);/g' {} +
    '';

  };
in
{
  environment.systemPackages = [
    mechsim-pkg
  ];
}
