{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    ## shell
    fastfetch

    helix
    emacs
    lazygit
    zoxide
    carapace
    tree
    xclip
    bat

    # language server
    cmake-language-server
    nil
    
    #hook
    direnv
    devenv
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
