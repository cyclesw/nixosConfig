{ config, pkgs, pkgs-unstable, ... }:

{
  home.username = "cyclesw";
  home.homeDirectory = "/home/cyclesw";

  home.packages = with pkgs; [
    git

    zsh
    neofetch
    lazygit
    fish

    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    clang-tools

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
