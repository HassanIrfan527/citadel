{ pkgs, ... }:
{
  programs.umbriel = {
    enable = true;
    settings = {
      general.autostart = [ "noctalia" ];
      layout.gap = 5;
      input.keyboard.layout = "us";

      keybinds = {
        "Mod+Return" = "spawn:kitty";
        "Mod+W" = "window-close";
        "Mod+Space" = "spawn:noctalia msg panel-toggle launcher";
      };
    };
  };
}
