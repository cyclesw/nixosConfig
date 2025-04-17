{config, lib, ...}:

{
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ./config);
#  xdg.dataFile."nvim".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ./data);
}
