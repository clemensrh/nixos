{ config, pkgs, ... }:

{
  home.packages = [ pkgs.swayosd ];

  services.swayosd = {
    enable = true;
    topMargin = 0.9;
    stylePath = "${config.xdg.configHome}/swayosd/style.css";
  };
}
