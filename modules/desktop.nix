{ pkgs, ... }:

{
  hardware.graphics.enable = true;

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.zsh.enable = true;
  users.users.clemens.shell = pkgs.zsh;

  programs.dconf.enable = true;

  services.usbmuxd.enable = true;

  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.noto
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];
}
