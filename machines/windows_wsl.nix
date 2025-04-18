{ inputs, system, enableGui, mypkgs, ... }:

let
  usernames = [
  "cyclesw"
  "root"
  ];

  userImports = builtins.listToAttrs (
    builtins.map (username: {
      name = username;
      value = import ../home/users/${username};
    }) usernames
  );

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
  # wsl only
    inputs.nixos-wsl.nixosModules.wsl
    {
      system.stateVersion = "24.11";
      wsl.enable = true;
    }

    { nix.registry.nixpkgs.flake = inputs.nixpkgs; }

    # file
    ../hosts/wsl
    ../modules

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users = userImports;

        extraSpecialArgs = specialArgs // inputs;
      };
    }
  ];
}