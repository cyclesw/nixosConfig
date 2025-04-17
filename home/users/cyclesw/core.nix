{config, specialArgs, nixpkgs, ...}:

{
  home.username = "cyclesw";
  home.homeDirectory = "/home/cyclesw";

  home.stateVersion = "24.11";
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
