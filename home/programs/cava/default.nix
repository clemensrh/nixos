{ lib, pkgs, ... }:

let
  cava-dynamic = pkgs.writeShellScriptBin "cava" ''
    mkdir -p "$HOME/.config/cava"
    cat "$HOME/.config/cava/config_base" "$HOME/.config/cava/colors" > "$HOME/.config/cava/config" 2>/dev/null
    exec ${pkgs.cava}/bin/cava "$@"
  '';
in
{
  home.packages = [ (lib.hiPrio cava-dynamic) ];

  xdg.configFile."cava/config_base".source = ./config;
}
