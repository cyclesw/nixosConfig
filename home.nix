{ config, pkgs, pkgs-unstable, ... }:

{
  home.username = "cyclesw";
  home.homeDirectory = "/home/cyclesw";

  home.packages = with pkgs; [
    zsh
    neofetch
    lazygit
  ];

  programs.zsh = {
    enable = true;
  };

  programs.git = {
    userName = "cyclesw";
    userEmail = "1939653182@qq.com";
  };


  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
