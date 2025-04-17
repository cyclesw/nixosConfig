{config, lib, ...}:

{
  xdg.configFile."mako".source = ./mako;
  xdg.configFile."waybar".source = ./waybar;
  xdg.configFile."mpd".source = ./mpd;
  xdg.configFile."anyrun".source = ./anyrun;
  xdg.configFile."hypr".source = ./hypr;
}
