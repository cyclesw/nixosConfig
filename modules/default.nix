{ config, lib, pkgs, ... }:

{
  imports = [
    ./users.nix
  ];

  environment.systemPackages = with pkgs; [
    wget
    neovim
    rustc
    cargo

    plocate


    ### Server DEV ENV ###
    etcd

    ### C++ DEV ENV ###
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    clang-tools

    ## global lib

    ## buildTools
    ninja
    cmake
    xmake
    pkg-config
    
    ### C# Dev Env 
    # dotnet-sdk_9
    dotnet-sdk_6


    ### Python3 Dev Env
    python3
    nodejs
  ];

  services.locate = {
    enable = true;
    localuser = null; # silence warning
    package = pkgs.plocate; # use faster locate implementation

    prunePaths = [
      "/media"
      "/mnt/c" # don't index windows drives in WSL
      "/mnt/d"
      "/mnt/e"
      "/mnt/f"
      "/mnt/wsl"
 #     "/nix/store"
      "/nix/var/log/nix"
      "/tmp"
      "/var/spool"
      "/var/tmp"
    ];
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vscode"
    ];

    permittedInsecurePackages = [
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-6.0.428"
    ];
  };


  programs = {
    nix-ld.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.variables.EDITOR = "nvim";
}
