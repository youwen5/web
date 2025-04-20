{
  description = "A static site generator using Typst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    crane.url = "github:ipetkov/crane";

    flake-utils.url = "github:numtide/flake-utils";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      crane,
      flake-utils,
      treefmt-nix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        craneLib = crane.mkLib pkgs;

        # Common arguments can be set here to avoid repeating them later
        # Note: changes here will rebuild all dependency crates
        commonArgs = {
          src = craneLib.cleanCargoSource ./.;
          strictDeps = true;

          buildInputs =
            [
              # Add additional build inputs here
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
              # Additional darwin specific inputs can be set here
              pkgs.libiconv
            ];
        };

        adamantite-crate = craneLib.buildPackage (
          commonArgs
          // {
            cargoArtifacts = craneLib.buildDepsOnly commonArgs;

            # Additional environment variables or build phases/hooks can be set
            # here *without* rebuilding all dependency crates
            # MY_CUSTOM_VAR = "some value";
          }
        );

        treefmtEval = treefmt-nix.lib.evalModule pkgs ./nix/treefmt.nix;
      in
      {
        checks = {
          inherit adamantite-crate;
          formatting = treefmtEval.config.build.check self;
        };

        packages.default = adamantite-crate;

        packages.book = pkgs.callPackage (
          {
            stdenvNoCC,
            mdbook,
          }:
          stdenvNoCC.mkDerivation {
            pname = "adamantite-book";
            version = if (self ? rev) then builtins.substring 0 6 self.rev else "unstable";

            src = ./docs;

            nativeBuildInputs = [ mdbook ];

            buildPhase = ''
              mdbook build
            '';

            installPhase = ''
              mkdir -p $out
              cp -r book/* $out
            '';
          }
        ) { };

        apps.default = flake-utils.lib.mkApp {
          drv = adamantite-crate;
        };

        apps.book = {
          type = "app";
          program = builtins.toString (
            pkgs.writeShellScript "serve" ''
              ${pkgs.live-server}/bin/live-server ${self.packages.${system}.book} --port 8080
            ''
          );
        };

        formatter = treefmtEval.config.build.wrapper;

        devShells.default = craneLib.devShell {
          # Inherit inputs from checks.
          checks = self.checks.${system};

          # Additional dev-shell environment variables can be set directly
          # MY_CUSTOM_DEVELOPMENT_VAR = "something else";

          # Extra inputs can be added here; cargo and rustc are provided by default.
          packages = with pkgs; [
            # pkgs.ripgrep
            rust-analyzer
            rustfmt
            clippy
            typst
          ];
        };
      }
    );
}
