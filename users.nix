{config, pkgs, ...}:

{
  users.mutableUsers = true;
  users.users.dweller = {
    isNormalUser = true;
    description = "Dweller";
    initialPassword = "dweller";

    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "keyd"
      "networkmanager"
      "input"
    ]; # 'wheel' enables sudo access
  };
}
