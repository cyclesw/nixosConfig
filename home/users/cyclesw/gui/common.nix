{pkgs, ...}:

{
  home.packages = with pkgs; [
    qq

    kitty
    alacritty
    libnotify

    clash-verge-rev

    # keyboar
    cliphist 
    wl-clipboard

    # screen
    brightnessctl

    #ide
    vscode
    jetbrains-toolbox
    jetbrains.clion

    google-chrome
    v2raya

    libsForQt5.qt5.qtwayland
  ];
}
