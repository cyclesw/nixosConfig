{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

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
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @{
    self,
    nixpkgs,
    home-manager,
    nix-ld, 
    nixos-wsl, 
    ... # input.xxxx 
    }: {
    # TODO 请将下面的 my-nixos 替换成你的 hostname
    nixosConfigurations = {

      wsl = let 
        username = "cyclesw";
      in
      nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit username;
        };

        modules = [
          # wsl only
          nixos-wsl.nixosModules.wsl
          {
            system.stateVersion = "24.11";
            wsl.enable = true;
          }

          { nix.registry.nixpkgs.flake = nixpkgs; }

          # file
          ./hosts/wsl.nix
          ./modules/default.nix


          # home 
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 这里的 ryan 也得替换成你的用户名
            # 这里的 import 函数在前面 Nix 语法中介绍过了，不再赘述
            home-manager.users.${username} = import ./users/${username}/home.nix;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            home-manager.extraSpecialArgs = specialArgs // inputs;
          }
        ];
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
