{ pkgs, ... }:

{
  imports = [
    ../../editor
    ../../programs/git
  ];

  home = {
    username = "clemens";
    homeDirectory = "/home/clemens";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    # Core CLI tools
    ripgrep
    tmux

    # System tools
    btop
    htop
    usbutils

    # Development
    biome
    bun
    gh
    nodejs_22
    python314
    uv

    # Media & Apps
    imagemagick
    microfetch
  ];
}
