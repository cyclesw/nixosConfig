{config, lib, pkgs, ...}: 


{
  imports = [
    ./elasticsearch
  ];

  programs = {
    fish.enable = true;
    nushell = {
      enable = true;
      configFile.source = ./nushell/config.nu;
      loginFile.source =  ./nushell/login.nu;
      extraConfig = ''
       '';
    };

    zoxide = { 
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      options = [
      ];
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  
    starship = {
      enable = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      loginExtra = "
      if [[ -o interactive ]]; then
          exec $(which nu)
      fi
      ";
      oh-my-zsh = {
        enable = true;
      };
    };

    bash = {
      enable = true;
      bashrcExtra = "
      ";
    };

    fzf = {
      enable = true;
    };
  };

  xdg.configFile."starship.toml".source = ./starship/starship.toml;  # Jetpack Preset
}
