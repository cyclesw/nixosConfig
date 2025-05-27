{nixpkgs, config, ...}:

let 
  helixPath = "${config.home.homeDirectory}/nix/home/users/cyclesw/tui/helix";
  nvimPath  = "${config.home.homeDirectory}/nix/home/users/cyclesw/tui/nvim";
in
{
  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink helixPath;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
}
