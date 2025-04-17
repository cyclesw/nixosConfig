{inputs, pkgs, config,  pkgs-unstable, ...}:

{
  environment.systemPackages = with pkgs-unstable; [
    # desktop 
    hyprland
    inputs.zen-browser.packages."x86_64-linux".default # beta

    gnome-shell-extensions
    clash-verge-rev
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      rime-data
      fcitx5-rime
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-nord
      libsForQt5.fcitx5-qt
      fcitx5-chinese-addons
    ];
  };

  programs.hyprland.enable = true;

  # environment.variables = {
  #   GTK_IM_MODULE = "fcitx";
  #   QT_IM_MODULE = "fcitx";
  #   XMODIFIERS = "@im=fcitx";
  # };
}
