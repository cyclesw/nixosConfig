{pkgs, ...}:

{
  home.packages = with pkgs; [
    qq

    kitty
    alacritty
    libnotify

    clash-verge-rev

    #ide
    vscode-fhs
    jetbrains-toolbox
    jetbrains.clion

    google-chrome
    v2ray
    v2raya
    nil

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
