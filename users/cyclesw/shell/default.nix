{config, lib, pkgs, zsh, ...}: 

# TODO: 分离nushell 
{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      # for editing directly to config.nu 
    };  

    zoxide = { 
      enable = true;
      enableNushellIntegration = true;

      options = [
      ];
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  
    starship = { enable = true;
      settings = {
        add_newline = true;
        character = { 
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    zsh = {
      enable = true;
      initExtraFirst = 
      ''
        if [[ $TERM != "dumb" ]]; then
          exec nu
        fi      
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        ];
      };
    };
  };
}
