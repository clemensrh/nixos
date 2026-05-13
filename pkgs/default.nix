pkgs: {
  openldap = pkgs.openldap.overrideAttrs (_old: {
    doCheck = false;
  });

  pkg-zen-browser = pkgs.callPackage ./zen-browser { };
  pkg-mistral-vibe = pkgs.callPackage ./mistral-vibe { };
  pkg-gtkpod = pkgs.callPackage ./gtkpod { };
}
