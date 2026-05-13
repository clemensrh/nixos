{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop.nix
    ../../modules/nvidia.nix
    ../../modules/audio.nix
    ../../modules/gaming.nix
    ../../modules/bluetooth.nix
    ../../modules/printing.nix
    ../../modules/development.nix
    ../../modules/unfree.nix
  ];

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://comfyui.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "comfyui.cachix.org-1:33mf9VzoIjzVbp0zwj+fT51HG0y31ZTK3nzYZAX0rec="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "snowflake";
  networking.networkmanager.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # TPM support for modern guest operating systems.
  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
  };

  programs.virt-manager.enable = true;

  users.users.clemens.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  services.openssh.enable = true;

  # Apple SuperDrive initialization rule
  # See: https://gist.github.com/yookoala/818c1ff057e3d965980b7fd3bf8f77a6
  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idProduct}=="1500", ATTRS{idVendor}=="05ac", DRIVERS=="usb", RUN+="${pkgs.sg3_utils}/bin/sg_raw --cmdset=1 %r/sr%n EA 00 00 00 00 00 01"
  '';

  environment.systemPackages = with pkgs; [
    libsecret
    handbrake
    virtiofsd
    # qemu_kvm
    # qemu
    inputs.comfyui-nix.packages.${pkgs.stdenv.hostPlatform.system}.cuda
  ];

  security.sudo.extraConfig = ''
    Defaults pwfeedback
    Defaults timestamp_timeout=120
  '';

  system.stateVersion = "25.11";
}
