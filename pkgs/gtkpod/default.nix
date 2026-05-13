{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  wrapGAppsHook3,
  intltool,
  libgpod,
  libxml2,
  curl,
  flac,
  adwaita-icon-theme ? null,
  gtk3,
  gettext,
  perlPackages,
  flex,
  libid3tag,
  gdl,
  libvorbis,
  gdk-pixbuf,
  file,
  python3,
}:

stdenv.mkDerivation rec {
  version = "2.1.5";
  pname = "gtkpod";

  src = fetchurl {
    url = "mirror://sourceforge/gtkpod/${pname}-${version}.tar.gz";
    sha256 = "0xisrpx069f7bjkyc8vqxb4k0480jmx1wscqxr6cpq1qj6pchzd5";
  };

  postPatch = ''
    # Fix /bin/bash shebangs
    patchShebangs version.sh
    patchShebangs scripts/*.sh

    sed -i 's/which/type -P/' scripts/*.sh

    # Make libanjuta optional (anjuta was removed from nixpkgs)
    # The configure script has two blocks that call as_fn_error when libanjuta is not found.
    # We need to replace the failure blocks with code that just sets empty variables and continues.
    python3 << 'PYEOF'
    with open('configure', 'r') as f:
        lines = f.readlines()

    new_lines = []
    i = 0
    while i < len(lines):
        line = lines[i]
        # Check if this is the start of an anjuta error block
        # The pattern is: "error: in" line, followed 2 lines later by "LIBANJUTA_PKG_ERRORS"
        if 'error: in' in line and 'ac_pwd' in line and i + 2 < len(lines) and 'LIBANJUTA_PKG_ERRORS' in lines[i + 2]:
            # Replace the 4-line error block with a harmless assignment
            indent = len(line) - len(line.lstrip())
            new_lines.append(' ' * indent + '{ have_anjuta=no; LIBANJUTA_CFLAGS=""; LIBANJUTA_LIBS=""; }\n')
            i += 4
            continue
        new_lines.append(line)
        i += 1

    with open('configure', 'w') as f:
        f.writelines(new_lines)
    PYEOF

    # Remove deprecated libxml2 calls that were removed in libxml2 2.9.0+
    sed -i '/xmlCleanupParser/d' libgtkpod/misc.c
    sed -i '/xmlMemoryDump/d' libgtkpod/misc.c
  '';

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook3
    intltool
    file
    python3
  ];
  buildInputs = [
    curl
    gettext
    flex
    libgpod
    libid3tag
    flac
    libvorbis
    libxml2
    gtk3
    gdk-pixbuf
    gdl
  ]
  ++ lib.optional (adwaita-icon-theme != null) adwaita-icon-theme
  ++ (with perlPackages; [
    perl
    XMLParser
  ]);

  # Workaround build failure on -fno-common toolchains like upstream
  # gcc-10. Otherwise build fails as:
  #   ld: .libs/autodetection.o:/build/gtkpod-2.1.5/libgtkpod/gtkpod_app_iface.h:248: multiple definition of
  #       `gtkpod_app'; .libs/gtkpod_app_iface.o:/build/gtkpod-2.1.5/libgtkpod/gtkpod_app_iface.h:248: first defined here
  env.NIX_CFLAGS_COMPILE = "-fcommon";

  enableParallelBuilding = true;

  meta = with lib; {
    description = "GTK Manager for an Apple ipod";
    homepage = "https://sourceforge.net/projects/gtkpod/";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
