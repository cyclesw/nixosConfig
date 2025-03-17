{config, specialArgs, nixpkgs, ...}:
let
  username = specialArgs.username;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "24.11";
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
