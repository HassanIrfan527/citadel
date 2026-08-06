{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    iconTheme = {
      name = "candy-icons";
    };

    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "Sweet-cursors";

    # Point Home Manager to use your manually installed theme folder instead of a nix package:
    package = pkgs.runCommand "local-cursor-theme" {} ''
      mkdir -p $out/share/icons
      ln -s ~/.local/share/icons/Sweet-cursors $out/share/icons/
    '';
    size = 28;
    gtk.enable = true;
    x11.enable = true;
  };
}
