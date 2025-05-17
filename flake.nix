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

    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # this is a professional, licensed font. you'll have to remove or replace
    # it to build the site locally
    valkyrie-font = {
      url = "github:youwen5/valkyrie";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    advisory-db = {
      url = "github:rustsec/advisory-db";
      flake = false;
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
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
      valkyrie-font,
      fenix,
      advisory-db,
      pre-commit-hooks,
      ...
    }:
    flake-utils.lib.eachSystem
      [
        "aarch64-linux"
        "x86_64-linux"
      ]
      (
        system:
        let
          pkgs = import nixpkgs { inherit system; };

          pnpm = pkgs.pnpm_10;

          rustToolchain = fenix.packages.${system}.complete.withComponents [
            "rustc"
            "cargo"
            "clippy"
            "rust-std"
            "rustfmt"
          ];

          craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;

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

          cargoArtifacts = craneLib.buildDepsOnly commonArgs;

          luminite-crate = craneLib.buildPackage (
            commonArgs
            // {
              inherit cargoArtifacts;

              # Additional environment variables or build phases/hooks can be set
              # here *without* rebuilding all dependency crates
              # MY_CUSTOM_VAR = "some value";
            }
          );

          web-assets =
            let
              pnpmDeps = pnpm.fetchDeps {
                pname = "site-pnpm-deps";
                src = ./web;
                hash = "sha256-3w4KeHN3HHCr8j4QF7NduKE60wGvleM8brGXHF1MpZU=";
              };
            in
            pkgs.stdenv.mkDerivation (finalAttrs: {
              name = "web-assets";

              src = ./.;

              pnpmRoot = "./web";

              nativeBuildInputs = [
                pkgs.nodejs
                pnpm.configHook
              ];

              inherit pnpmDeps;

              buildPhase = ''
                cd web
                ln -s ${pnpmDeps} node_modules
                pnpm build
              '';

              installPhase = ''
                cp -r dist $out
              '';
            });

          treefmtEval = treefmt-nix.lib.evalModule pkgs ((import ./nix/treefmt.nix) rustToolchain);

          typst-packages = pkgs.fetchFromGitHub {
            owner = "typst";
            repo = "packages";
            rev = "e851e6d6638e47ec73aeee04d6a808cf8f72df38";
            hash = "sha256-dzZk2wDjJGYTGp0EKRyf9qNu9aBlOFwI2ME/ZCPScqs=";
            sparseCheckout = [
              "packages/preview/cetz/0.3.4"
              "packages/preview/oxifmt/0.2.1"
            ];
          };

          typstPackagesSrc = "${typst-packages}/packages";

          typstPackagesCache = pkgs.stdenv.mkDerivation {
            name = "typst-packages-cache";
            src = typstPackagesSrc;
            dontBuild = true;
            installPhase = ''
              mkdir -p "$out/typst/packages/luminite"
              cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages" "$src"/*
              cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages/luminite" ${
                self.packages.${system}.default.src
              }/typst/lib/html-shim
            '';
          };
        in
        {
          formatter = treefmtEval.config.build.wrapper;

          checks = {
            inherit luminite-crate;

            luminite-clippy = craneLib.cargoClippy (
              commonArgs
              // {
                inherit cargoArtifacts;
                cargoClippyExtraArgs = "--all-targets -- --deny warnings";
              }
            );

            luminite-doc = craneLib.cargoDoc (
              commonArgs
              // {
                inherit cargoArtifacts;
              }
            );

            luminite-deny = craneLib.cargoDeny {
              inherit (commonArgs) src;
              inherit advisory-db;
            };

            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                treefmt.enable = true;
                treefmt.package = treefmtEval.config.build.wrapper;
                check-merge-conflicts.enable = true;
              };
            };
          };

          # the actual site, with the fonts bundled within
          packages.full = self.packages.${system}.default.overrideAttrs (
            finalAttrs: prevAttrs: {
              name = "site";

              TYPST_FONT_PATHS = pkgs.symlinkJoin {
                name = "fonts";
                paths = [
                  valkyrie-font.packages.${pkgs.stdenv.hostPlatform.system}.default
                ];
              };

              buildPhase =
                # install licensed fonts from private repo
                ''
                  mkdir -p public/fonts
                  cp "${valkyrie-font}/WOFF2/OT-family/Valkyrie-OT/"*.woff2 public/fonts
                  cp "${valkyrie-font}/concourse-index/WOFF2/concourse_index_regular.woff2" public/fonts
                ''
                + prevAttrs.buildPhase;
            }
          );

          # builds the site without fonts which are in private repo
          packages.default = pkgs.stdenv.mkDerivation {
            name = "site-without-fonts";

            src = ./.;

            nativeBuildInputs = [
              self.packages.${system}.luminite
              pkgs.typst
              pkgs.git
            ];

            XDG_CACHE_HOME = typstPackagesCache;
            LUMINITE_GIT_COMMIT = builtins.toString (if (self ? rev) then self.rev else "unstable");
            LUMINITE_LAST_MODIFIED = builtins.toString (self.lastModified);

            buildPhase = ''
              site build --minify
            '';

            installPhase = ''
              mkdir -p $out
              cp -r ${web-assets}/* dist/
              cp -r dist $out/dist
            '';
          };

          packages.luminite = luminite-crate;

          apps =
            let
              preview-drv =
                withFonts:
                let
                  siteFiles = if withFonts then self.packages.${system}.full else self.packages.${system}.default;
                  caddyfile = pkgs.writeText "Caddyfile" ''
                    :8000 {
                        root * ${siteFiles}/dist
                        file_server
                        try_files {path} {path}.html {path}/ =404
                        header Cache-Control max-age=0
                    }
                  '';

                  formattedCaddyfile = pkgs.runCommand "Caddyfile" {
                    nativeBuildInputs = [ pkgs.caddy ];
                  } ''(caddy fmt ${caddyfile} || :) > "$out"'';

                  script = pkgs.writeShellApplication {
                    name = "preview";

                    runtimeInputs = [ pkgs.caddy ];

                    text = "caddy run --config ${formattedCaddyfile} --adapter caddyfile";
                  };

                in
                script;
            in
            {
              default = flake-utils.lib.mkApp {
                drv = luminite-crate;
              };

              preview = flake-utils.lib.mkApp {
                drv = preview-drv false;
              };

              # only works if you have access to my private repo containing licensed fonts
              preview-with-fonts = flake-utils.lib.mkApp {
                drv = preview-drv true;
              };
            };

          devShells.default =
            let
              rustPkgs = fenix.packages.${system};
              rustToolchain = rustPkgs.complete.withComponents [
                "rustc"
                "cargo"
                "rustfmt"
                "rust-docs"
                "rust-analyzer"
                "clippy"
                "rust-src"
                "rust-std"
              ];
            in
            craneLib.devShell {
              # Inherit inputs from checks.
              checks = self.checks.${system};

              RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";

              packages =
                [ pnpm ]
                ++ (with pkgs; [
                  typst
                  tailwindcss-language-server
                  nodejs
                  just
                  caddy
                  cargo-valgrind
                ])
                ++ [
                  rustToolchain
                ];
            };
        }
      );

  nixConfig = {
    extra-substituters = [
      "https://luminite.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "luminite.cachix.org-1:+VgO/GJMmqsp4U79+QFle7TtEwT8LrJXPiImA8a3a3o="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
