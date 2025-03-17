{ config, pkgs, lib, pkgs-unstable, username, enableGui, ... }:

{
  imports = [
    ./core.nix
    ./common.nix
    ./shell
  ] ++ (if enableGui == true then [ ./gui ] else [ ]);

  programs = {
    git = {
      enable = true;
      userName = username;
      userEmail = "1939653182@qq.com";
    };
  };
}
