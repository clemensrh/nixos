{
  stdenv,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
  pango,
  gtk3,
  glibc,
  alsa-lib,
}:

let
  rev = "1.17.15b";
  linux_x86_64-hash = "0y476zd2sxax2j7ncqcyglcyn22v3anqjbqqkfpv0qaww9crvvqk";
  domain = "github.com";
  owner = "zen-browser";
  repo = "desktop";
  repo_git = "https://${domain}/${owner}/${repo}";
in
stdenv.mkDerivation (finalAttrs: {
  pname = "zen-browser";
  version = "${rev}";

  src = fetchurl {
    url = "${repo_git}/releases/download/${rev}/zen.linux-x86_64.tar.xz";
    sha256 = linux_x86_64-hash;
  };

  unpackPhase = ''
    mkdir -p $out
    tar xJvf ${finalAttrs.src} -C $out
  '';

  nativeBuildInputs = [
    alsa-lib
    autoPatchelfHook
    glibc
    gtk3
    pango
    stdenv.cc.cc.lib
  ];

  buildInputs = [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin
    makeWrapper "$out/zen/zen-bin" "$out/bin/zenbrowser"
  '';
})
