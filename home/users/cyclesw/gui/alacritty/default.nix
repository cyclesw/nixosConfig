{pkgs, config, ...}:


{
  programs.alacritty = {
    enable = true;
  }; 

  # xdg.configFile."alacritty".source = ./config;
  xdg.configFile."alacritty".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ./config);
}
