{ config, lib, pkgs-unstable, inputs, modulesPath, ... }:

{
  imports = [
    ./wsl.nix
    ./configuration.nix
  ];
}
