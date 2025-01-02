{ config, pkgs, ... }:

{
  home.username = "cyclesw";
  home.homeDirectory = "/home/cyclesw";

  home.packages = with pkgs;[
    neofetch
    fish
  ];

  programs.fish =
    {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        {
          name = "z";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "z";
            rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
            sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
          };
        }
      ];
    };

  # shellAliases = {
  #   ll = "ls -la";
  # };

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
