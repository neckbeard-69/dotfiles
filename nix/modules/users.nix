{ pkgs, ... }:

{
  users.users.mohammed = {
    isNormalUser = true;
    description = "mohammed";
    shell = pkgs.fish;

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
