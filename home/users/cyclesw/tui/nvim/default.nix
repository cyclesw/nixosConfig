{config, lib, ...}:

let 
  # nvimPath = "${config.home.homeDirectory}/nix/home/users/cyclesw/tui/nvim/config";
in
{
  xdg.configFile."nvim".source = ./config;
}