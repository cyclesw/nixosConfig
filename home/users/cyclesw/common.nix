{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    ## shell
    neofetch

    helix
    lazygit
    zoxide
    carapace
    tree
    xclip
    bat

    #hook
    direnv
  ];

  programs = {
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };

  programs.neovim.defaultEditor = true;
}
