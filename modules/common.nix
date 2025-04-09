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

    ### Server DEV ENV
    etcd
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

  fonts.packages = with pkgs; [
      jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.variables.EDITOR = "nvim";
}
