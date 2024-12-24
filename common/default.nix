{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git 
    wget
    clang
    rustc
    cargo
    neovim
  ];

  environment.variables.EDITOR = "nvim";
}
