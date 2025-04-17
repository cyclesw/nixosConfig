{pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    wget
    neovim
    rustc
    cargo
    nix-search-cli

    # shell
    nushell
    zsh
    plocate
    unzip
    file

    ### Server DEV ENV
    pkgs-stable.etcd
    elasticsearch
    rsync
    

    ### C++ DEV ENV
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    llvmPackages_latest.lld
    clang-tools
    gcc
    gdb
    gnumake

    ## global lib

    ## buildTools
    ninja
    cmake
    xmake
    pkg-config
    
    ### C# Dev Env 
    dotnet-sdk_6

    # vue
    nodejs

    ### Python3 Dev Env
    python3
  ];


  programs.zsh.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "elasticsearch"
  ];

  programs = {
    nix-ld.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
    fontDir.enable = true;
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
}
