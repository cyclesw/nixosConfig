{config, lib, pkgs, zsh, ...}: 


{
  imports = [
    ./elasticsearch
  ];

  programs = {
    nushell = {
      enable = true;
      configFile.source = ./nushell/config.nu;
      loginFile.source =  ./nushell/login.nu;
      extraConfig = ''
        def nix-switch [name: string, path = "/etc/nixos/"] {
            nixos-rebuild switch --flake $"(path)#(name)"
        }
        
        def nix-clean [] {
            nix-env --profile /nix/var/nix/profiles/system --delete-generations +3   
            nix-collect-garbage --delete-older-than 7d
        }
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
  # xdg.configFile."nushell".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ./nushell);
}
