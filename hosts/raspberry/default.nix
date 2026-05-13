{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "raspberry";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [ ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
