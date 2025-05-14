{config, ...}:

let 
  helixPath = "${config.home.homeDirectory}/nix/home/users/cyclesw/tui/helix/config";
in
{
  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink helixPath;
}
