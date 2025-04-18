{config, specialArgs, nixpkgs, ...}:

{
  home.username = "root";
  home.homeDirectory = "/root";

  home.stateVersion = "24.11";
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
