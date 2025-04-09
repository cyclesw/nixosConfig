{config, lib, ...}:

let
  nvimDir = "${config.home.homeDirectory}/nix/users/cyclesw/tui/nvim/config";
in
{
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimDir;
}