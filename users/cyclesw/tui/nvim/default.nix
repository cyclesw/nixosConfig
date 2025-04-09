{pkgs, lib, config, ...}:

let
  nvimDir = "${config.home.homeDirectory}"

in
{
  xdg.configFile."nvim".source = ./config;
}