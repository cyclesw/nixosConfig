{pkgs, config, ...}:

{
  imports = [
    ../../home
    ./configuration.nix
    ./nvidia.nix
  ];
}
