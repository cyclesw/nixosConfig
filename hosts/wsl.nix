{ config, lib, pkgs-unstable, inputs, modulesPath, ... }:

{
  imports = [
    # include NixOS-WSL modules
    "${modulesPath}/profiles/minimal.nix"
  ];

  wsl.enable = true;
  wsl.defaultUser = "cyclesw";
  #  wsl.nativeSystemd = true;
  networking.hostName = "wsl";

  wsl.wslConf = {
    automount = {
      enabled = true;
    };
    user = {
      default = "cyclesw";
    };
    interop = {
      enabled = true;
      appendWindowsPath = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
