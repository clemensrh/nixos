{ pkgs, ... }:

{
  home.packages = [ pkgs.swaynotificationcenter ];

  xdg.configFile."swaync/config.json".source = ./config.json;
}
