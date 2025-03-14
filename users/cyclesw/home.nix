{ config, pkgs, lib, pkgs-unstable, specialArgs, ... }:

{
  imports = [
    ./core.nix
    ./common.nix
    ./shell
  ];

  programs = {
    git = {
      enable = true;
      userName = specialArgs.username;
      userEmail = "1939653182@qq.com";
    };
  };
}
