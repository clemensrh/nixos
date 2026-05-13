{ pkgs, inputs, ... }:

{
  imports = [
    ../base
    ../..
    ../../programs/matugen
    ../../programs/swaync
    ../../programs/swayosd
    ../../programs/cava
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  home.packages = with pkgs; [
    # Development
    vscode

    # Media & Apps
    cider-2
    vlc
    easyeffects
    steam
    vesktop
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    bluez
    rapidraw
    localsend
    prismlauncher
    rockbox-utility
    rhythmbox
    rpi-imager

    # System tools
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    grimblast
    nautilus
    playerctl
    wlr-randr
    quickshell
    brightnessctl
    papirus-icon-theme
    cliphist
    wl-clipboard
    wireplumber
    swww
    swaynotificationcenter
    swayosd
    pamixer
    jq
    socat
    bc
    ffmpeg
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtwebsockets
    lxqt.lxqt-policykit
    upower
    libgpod
    sg3_utils
    # wineWow64Packages.stable
    # winetricks
    # bottles
  ];
}
