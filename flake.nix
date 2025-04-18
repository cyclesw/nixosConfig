{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:Nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:Nixos/nixpkgs/nixos-24.11";

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

    macos = let 
      username = "cyclesw";
      specialArgs = { inherit username; };
    in
      nixpkgs.lib.nixosSystem 
      {
        system = "aarch64-linux";
        modules = [
          ./configuration.nix
          ./modules/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.cyclesw = import ./users/${username}/home.nix;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            home-manager.extraSpecialArgs = inputs // specialArgs;
          }
        ];
      };
    };
  };
}
