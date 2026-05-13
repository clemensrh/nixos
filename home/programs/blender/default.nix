{ pkgs, ... }:
let
  immutable-views =
    pythonPkgs:
    pythonPkgs.buildPythonPackage rec {
      pname = "immutable-views";
      version = "0.6.1";
      pyproject = true;

      src = pythonPkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-SOBUN4booZZmf7hBLONcT1Vc4I856rIdz0sKI9jRkpU=";
      };

      nativeBuildInputs = with pythonPkgs; [
        setuptools
        wheel
      ];

      doCheck = false;
    };

  mcschematic =
    pythonPkgs:
    pythonPkgs.buildPythonPackage rec {
      pname = "mcschematic";
      version = "11.4.4";
      pyproject = true;

      src = pythonPkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-znFMkoC1acz4rXf2FgZHwshxCnyFQ31sKMf5Qk9+jns=";
      };

      nativeBuildInputs = with pythonPkgs; [
        setuptools
        wheel
      ];

      propagatedBuildInputs = with pythonPkgs; [
        nbtlib
        (immutable-views pythonPkgs)
      ];

      doCheck = false;
    };

  blenderWithPackages = pkgs.blender.withPackages (pythonPkgs: [
    pythonPkgs.pillow
    (mcschematic pythonPkgs)
  ]);

  blenderCommandShim = pkgs.writeShellScriptBin "blender" ''
    exec blender-wrapped "$@"
  '';
in
{
  home.packages = [
    blenderCommandShim
    blenderWithPackages
  ];
}
