{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable DRM modesetting for the NVIDIA kernel driver so Wayland compositors
  # (wlroots/Hyprland) can use it. This sets the kernel command line option
  # required for `nvidia-drm` and ensures modules are available early.
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
  ];
}
