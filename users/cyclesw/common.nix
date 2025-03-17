{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    # shell
    neofetch
    lazygit
    nushell
    zoxide
    carapace

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
