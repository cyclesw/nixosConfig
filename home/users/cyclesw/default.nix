{ config, pkgs, lib, pkgs-unstable, username, enableGui, ... }:

{
  imports = [
    ./core.nix
    ./common.nix
    ./shell
    ./tui
  ] ++ (if enableGui == true then [ ./gui ] else [ ]);

  programs = {
    git = {
      enable = true;
      userName = "cyclesw";
      userEmail = "1939653182@qq.com";
    };
  };
}
