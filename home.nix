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
    
    ### Server DEV ENV ###
    etcd

    ### C++ DEV ENV ###
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    clang-tools

    dotnet-sdk_9
  ];

  programs.zsh = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "cyclesw";             #TODO: 清空
    userEmail = "1939653182@qq.com";
  };


  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
