{ ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "";
          path = "/etc/nixos/home/wm/wallpapers/image.png";
          fit_mode = "cover";
        }
      ];
    };
  };
}
