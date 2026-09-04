{ pkgs, ... }:
{

  programs.opencode = {
    enable = true;

    settings = {
      model = "anthropic/claude-sonnet-4-20250514";
      autoupdate = false;
    };
  };
}
