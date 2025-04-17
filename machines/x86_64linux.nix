# nixos/wsl.nix
{ inputs, system, enableGui, mypkgs, ... }:

let 
  usernames = [
  "cyclesw"
  "root"
  ];
in
  inputs.nixpkgs.lib.nixosSystem rec {
  inherit system;

  specialArgs = {
    pkgs-unstable = (mypkgs system).pkgs-unstable;
    pkgs-stable = (mypkgs system).pkgs-stable;
    inherit system;
    inherit inputs;
    inherit enableGui;
  };

  modules = [
    ../hosts/desktop
    ../modules

    # Home Manager 集成
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users = {
          cyclesw = import ../home/users/cyclesw/home.nix;
        };

        extraSpecialArgs = specialArgs // inputs;
      };
    }
  ];
}
