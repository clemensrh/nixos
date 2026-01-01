{ pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.vicinae.homeManagerModules.default
    ./hyprland.nix
    ./programs
  ];

  home = {
    username = "clemens";
    homeDirectory = "/home/clemens";
    stateVersion = "25.11";

    packages = with pkgs; [
      # Development
      nodejs_22
      bun
      vscode
      github-copilot-cli
      gemini-cli-bin

      # Media & Apps
      cider-2
      vlc

      # System tools
      ghostty
      grimblast
      nautilus
      playerctl
      hyprpolkitagent
    ];
  };

  programs.home-manager.enable = true;
  programs.zen-browser.enable = true;

  services.vicinae = {
    enable = true;
    autoStart = true;
  };

  systemd.user.startServices = "sd-switch";
}
