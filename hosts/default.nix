{
  nixpkgs,
  home-manager,
  inputs,
  pkgsOverlay ? _: _: { },
}:

let
  mkHost =
    {
      name,
      system ? "x86_64-linux",
      homeProfile ? name,
      modules ? [ ],
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./base.nix
        ./${name}/default.nix
        {
          nixpkgs.overlays = [
            pkgsOverlay
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.clemens = import ../home/profiles/${homeProfile};
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ]
      ++ modules;
    };
in
{
  snowflake = mkHost {
    name = "snowflake";
  };

  raspberry = mkHost {
    name = "raspberry";
    system = "aarch64-linux";
  };
}
