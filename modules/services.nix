{pkgs, ...}:

{
  services.elasticsearch = {
    enable = true;
  };

  services.elasticsearch = {
    plugins = [
      # pkgs.elasticsearchPlugins.analysis-smartcn
      (pkgs.callPackage ./elasticsearch/plugins.nix {}).analysis-ik
    ];
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate; # use faster locate implementation

    prunePaths = [
      "/media"
      "/mnt/c" # don't index windows drives in WSL
      "/mnt/d"
      "/mnt/e"
      "/mnt/f"
      "/mnt/wl"
 #     "/nix/store"
      "/nix/var/log/nix"
      "/tmp"
      "/var/spool"
      "/var/tmp"
    ];
  };

}
