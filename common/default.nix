{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    clang
    rustc
    cargo
    neovim
    cmake
    xmake
    lazygit
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  environment.variables.EDITOR = "nvim";
}
