{ packsquash, ... }:
{ ... }:
{
  config.perSystem = { inputs', self', pkgs, ... }:
    let
      getDefaultInputAttrs = attr: names:
        builtins.listToAttrs (
          builtins.map (
            name: {
              inherit name;
              value = inputs'.${name}.${attr}.default;
            }
          )
          names
        );
    in {
      packages =
        let
          getDefaultInputPackages = getDefaultInputAttrs "packages";

          defaultInputPackages = getDefaultInputPackages ["packsquash"];
        in
          defaultInputPackages // {

          };

      devShells.default = pkgs.mkShell {
        packages = [
          self'.packages.packsquash
        ];
      };
  };
}
