{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:Nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:Nixos/nixpkgs/nixos-25.05";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up to date or simply don't specify the nixpkgs input  
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @{
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    nix-ld, 
    nixos-wsl, 
    ... # input.xxxx 
    }: let
      mypkgs = system: inputs //{
        pkgs-unstable = import nixpkgs-unstable {
	        inherit system;
	        config.allowUnfree = true;
	      };     

	      pkgs-stable = import nixpkgs-stable {
	        inherit system;
	        config.allowUnfree = true;
	      };
	    };

       #  pkgs-unstable = import nixpkgs-unstable {
	      #   inherit (system: inputs);
	      #   config.allowUnfree = true;
	      # };     
							#
	      # pkgs-stable = import nixpkgs-stable {
	      #   inherit (system: inputs);
	      #   config.allowUnfree = true;
	      # };
							#
    in {
    nixosConfigurations = {

      amd64-linux = import ./machines/x86_64linux.nix {
        inherit inputs mypkgs;
        enableGui = true;
        system = "x86_64-linux";
      };

      wsl = import ./machines/windows_wsl.nix {
        inherit inputs mypkgs;
        enableGui = false;
        system = "x86_64-linux";
      };

      macos = import ./machines/macos.nix {
        inherit inputs mypkgs;
        enableGui = false;
        system = "aarch64-linux";
      };
    };
  };
}
