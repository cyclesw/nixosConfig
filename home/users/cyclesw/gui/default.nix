{pkgs,  ...}:

{
  imports = [
    ./common.nix
    ./alacritty
    ./hyprland
  ];


  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
