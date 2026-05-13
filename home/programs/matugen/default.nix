{ pkgs, ... }:

{
  home.packages = [ pkgs.matugen ];

  xdg.configFile."matugen/config.toml".source = ./config.toml;
  xdg.configFile."matugen/templates".source = ./templates;
}
