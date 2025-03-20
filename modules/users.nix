{ config, pkgs, ... }:

{
  users.users.cyclesw = {
    isNormalUser = true;
    home = "/home/cyclesw";
    createHome = true;
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
    group = "users";
    shell = pkgs.zsh;
  };
}
