{ config, lib, pkgs, enableGui, ... }:

{
  imports = [
    ./common.nix
    ./users.nix
    ./net
    ./services.nix
  ];

}
