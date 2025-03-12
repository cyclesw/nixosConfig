{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    neovim
    rustc
    cargo

    plocate


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

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
  ];

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.variables.EDITOR = "nvim";
}
