{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    comfyui-nix.url = "github:utensils/comfyui-nix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      customPkgs = import ./pkgs;
      customOverlay = final: prev: customPkgs prev;

      hosts = import ./hosts {
        inherit nixpkgs home-manager inputs;
        pkgsOverlay = customOverlay;
      };
    in
    {
      nixosConfigurations = hosts;
    };
}
