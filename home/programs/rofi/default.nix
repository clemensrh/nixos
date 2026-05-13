{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "${config.xdg.configHome}/rofi/theme.rasi";
    font = "JetBrainsMono Nerd Font 12";
    terminal = "ghostty";

    extraConfig = {
      modi = "drun,filebrowser,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";

      display-drun = "";
      display-window = "";
      display-filebrowser = "";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";

      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
      case-sensitive = false;
    };
  };
}
