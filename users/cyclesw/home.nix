{ config, pkgs, lib, pkgs-unstable, username, ... }:

{
  imports = [
    ./core.nix
    ./common.nix
    ./shell
    ./gui
  ];

  programs = {
    git = {
      enable = true;
      userName = username;
      userEmail = "1939653182@qq.com";
    };
  };
}
