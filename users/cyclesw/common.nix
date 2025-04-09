{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    ## shell
    neofetch
    lazygit
    nushell
    zoxide
    carapace
    tree
    xclip
    bat

    #zsh
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting

    #hook
    direnv
  ];

  programs = {
    direnv = {
      enable = true;
      # enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
