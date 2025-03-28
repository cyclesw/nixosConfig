{pkgs, pkgs-unstable, ...}:

{
  home.packages = with pkgs-unstable; [
    microsoft-edge
    opera
    qq

    kitty

    #ide
    vscode
    jetbrains-toolbox
    jetbrains.clion

    google-chrome
    mihomo-party
    clash-nyanpasu
    clash-verge-rev
    v2ray
    v2raya

    ## wayland
    swaybg
    wl-clipboard

    # keyboar
    cliphist 
    wl-clipboard

    hyprland
    pyprland
    xwayland
    waybar
    hyprcursor
    hypridle
    rofi
    wlogout
    hyprshade
    waypaper
    anyrun
    mako
    gdm
    libsForQt5.qt5.qtwayland
  ];


}
