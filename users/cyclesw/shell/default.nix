{config, lib, pkgs, zsh, ...}: 

# TODO: 分离nushell 
{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./nushell/config.nu;
      loginFile.source =  ./nushell/login.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        $env.ES_HOME = "${pkgs.elasticsearch}"
      '';
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
  
    starship = {
      enable = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
      };
    };
  };

  xdg.configFile."starship.toml".source = ./starship/starship.toml;  # Jetpack Preset
  
}
