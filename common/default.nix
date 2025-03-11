{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    clang
    neovim
    cmake
    xmake
    rustc
    cargo
    nodejs_23
  ];

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.variables.EDITOR = "nvim";
}
