{pkgs, config, lib, ...}:

{
  home.packages = with pkgs; [
    ## wayland
    swaybg


    hyprland
    pyprland
    xwayland
    waybar
    # hyprcursor
    hypridle
    rofi
    wlogout
    hyprlock
    # hyprshade
    # waypaper
    anyrun
    mako
  ];
  
  xdg.configFile."mako".source = ./mako;
  xdg.configFile."waybar".source = ./waybar;
  xdg.configFile."mpd".source = ./mpd;
  xdg.configFile."anyrun".source = ./anyrun;
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ./hypr);
}
