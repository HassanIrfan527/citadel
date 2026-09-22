{
  config,
  pkgs,
  inputs,
  ...
}:

{
  environment = {

    localBinInPath = true;
    # Environment variables
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      BROWSER = "brave";
    };

    # Session variables (Wayland support for Electron apps)
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # System-wide packages
    systemPackages = with pkgs; [

      # Terminal Utilities
      kitty
      ripgrep
      fd
      fzf
      bat
      glow
      tldr # Simplified help pages
      zoxide # Smarter 'cd' command
      yazi # Terminal file manager
      superfile # Modern terminal file manager
      television # Smart fuzzy finder / launcher
      scooter # Interactive terminal search tool
      fuzzel
      starship
      fastfetch
      gh
      jq
      home-manager
      btop
      tree
      atuin
      direnv

      # Development Languages & Runtimes
      python3 # Python programming language
      php # PHP scripting language
      phpPackages.composer # PHP dependency manager
      nodejs # JavaScript runtime
      go # Go programming language
      sqlite # Lightweight SQL database engine
      cargo
      sheldon
      gcc
      gnumake
      pkg-config
      rustup
      tree-sitter
      curl
      zip
      unzip
      gnutar
      ninja
      cmake
      jdk
      bash-language-server
      shellcheck
      shfmt
      clang
      clang-tools
      gdb
      appimage-run

      # Developer Tools & Utilities
      lazygit # Terminal UI for git commands
      nixfmt # Nix code formatter
      nixd # Nix language server
      lua-language-server
      claude-code # Claude CLI tool
      podman-tui # Terminal UI for Podman containers
      podman-compose
      bitwarden-cli # Password manager CLI
      lazysql
      rbw # Bitwarden rust-alternative. Fast and reliable
      opencode

      # System, Hardware & Network
      intel-media-driver # Hardware video acceleration for Intel
      cifs-utils # Tools for mounting SMB/CIFS shares
      keyd # Keyboard remapping daemon
      bucklespring-libinput
      pavucontrol # PulseAudio / PipeWire volume control
      weathr # Terminal weather app
      adwaita-icon-theme # Standard GTK icon theme
      grim
      slurp
      wl-clipboard
      swappy

      # Desktop Applications
      obsidian # Note-taking app
      blender # 3D creation suite
      zed-editor # Fast code editor
      qutebrowser # Keyboard-focused browser
      vlc # Media player
      qbittorrent # Torrent client
      vesktop # Custom Discord desktop client
      ollama # Local AI model runner
      xwayland # X11 compatibility layer for Wayland
      brave # Privacy-focused web browser
      nautilus
      newsboat
      newsflash

      # Gaming & Emulation
      steam # Steam gaming platform
      wine # Windows compatibility layer (32/64-bit)
      wineWow64Packages.stable # Stable Wine WOW64 package
      winetricks # Helper script for Wine configuration
      protontricks # Helper script for Proton configuration
      mangohud # Performance overlay for gaming
      game-devices-udev-rules # Udev rules for controllers and game devices
      lutris
      umu-launcher
      steam-run
      protonup-qt
      gamescope
      vkbasalt

      # Extra
      playerctl
      nss
      glib
      adw-gtk3
      xwayland-satellite
      gpu-screen-recorder
      distrobox
      bibata-cursors
      pinentry-curses
      brightnessctl
      cliphist
      hyprcursor
      # ── The Sanctuary — desktop chrome ──
      waybar
      swaynotificationcenter # notifications + the centre
      mako # inactive fallback; see ~/.dotfiles/DESIGN-BRIEF.md §5
      swww # wallpaper daemon — replaces noctalia's wallpaper layer
      swaylock-effects # locker, reached by `loginctl lock-session`
      swayidle # idle -> lock
      wl-gammarelay-rs # night light — manual, keybind-adjusted, DBus-driven
      wiremix # TUI audio mixer, opened from the bar's mic module
      libnotify # notify-send, for testing notifications by hand
      inputs.nix-graph.packages.${pkgs.stdenv.hostPlatform.system}.nix-graph

    ];
  };
}
