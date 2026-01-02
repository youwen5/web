{
  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit.url = "github:cachix/git-hooks.nix";
    pre-commit.inputs.nixpkgs.follows = "nixpkgs";

    # this is a professional, licensed font, in a private repository
    valkyrie-font = {
      url = "github:youwen5/valkyrie";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      haskellNix,
      pre-commit,
      valkyrie-font,
      treefmt-nix,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        overlays = [
          haskellNix.overlay
          (final: _prev: {
            haskell-nix = _prev.haskell-nix // {
              extraPkgconfigMappings = _prev.haskell-nix.extraPkgconfigMappings // {
                # String pkgconfig-depends names are mapped to lists of Nixpkgs
                # package names
                "z3" = [ "z3" ];
              };
            };
            rednoiseProject = final.haskell-nix.project' {
              src = ./.;
              compiler-nix-name = "ghc9122";
              # This is used by `nix develop .` to open a shell for use with
              # `cabal`, `hlint` and `haskell-language-server`
              shell.tools = {
                cabal = { };
                hlint = { };
                haskell-language-server = { };
                cabal-gild = { };
                fourmolu = { };
              };
              # Non-Haskell shell tools go here
              shell.buildInputs =
                (with pkgs; [
                  just
                  tailwindcss_4
                  self.packages.${system}.typst-html-wrapper
                  rsync
                ])
                ++ [ typst ];
            };
          })
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
          inherit (haskellNix) config;
        };

        flake = pkgs.rednoiseProject.flake { };

        typst = pkgs.typst.withPackages (
          p: with p; [
            fletcher_0_5_8
            cetz_0_4_2
            oxifmt_0_2_1
            cmarker_0_1_5
            showybox_2_0_4
            self.packages.${system}.html-shim
          ]
        );

        treefmtEval = treefmt-nix.lib.evalModule pkgs ((import ./nix/treefmt.nix) { inherit pkgs; });

      in
      flake
      // {
        formatter = treefmtEval.config.build.wrapper;

        checks = {

          pre-commit-check = pre-commit.lib.${system}.run {
            src = ./.;
            hooks = {
              treefmt.enable = true;
              treefmt.package = treefmtEval.config.build.wrapper;
              check-merge-conflicts.enable = true;
              hlint.enable = true;
              cabal-gild.enable = true;
              trim-trailing-whitespace.enable = true;
              end-of-file-fixer.enable = true;
              mixed-line-endings.enable = true;
            };
          };
        };

        packages = flake.packages // {
          rednoise-unwrapped = flake.packages."rednoise:exe:rednoise";
          rednoise = pkgs.stdenvNoCC.mkDerivation {
            name = "rednoise";
            src = self.packages.${system}.rednoise-unwrapped;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            installPhase = ''
              install -Dm755 ./bin/rednoise $out/bin/rednoise
              wrapProgram $out/bin/rednoise \
                --prefix PATH : ${
                  pkgs.lib.makeBinPath [
                    self.packages.${system}.typst-html-wrapper
                    pkgs.tailwindcss_4
                    typst
                  ]
                }
            '';
          };
          # website without licensed fonts -- everything will work but no fonts
          site-demo = pkgs.stdenvNoCC.mkDerivation {
            name = "site";
            src = ./.;
            nativeBuildInputs = [ self.packages.${system}.rednoise ];

            LANG = "en_US.UTF-8";
            LOCALE_ARCHIVE = pkgs.lib.optionalString (
              pkgs.stdenv.buildPlatform.libc == "glibc"
            ) "${pkgs.glibcLocales}/lib/locale/locale-archive";

            TZ = "America/Los_Angeles";
            GIT_COMMIT_HASH = builtins.toString (if (self ? rev) then self.rev else "unstable");
            LAST_COMMIT_TIMESTAMP = builtins.toString (self.lastModified);

            buildPhase = ''
              rednoise build
            '';
            installPhase = ''
              mkdir -p $out
              mv ./_site/* $out
            '';
          };

          # actual website to be deployed in production (cannot be built without access to private repo)
          site-full = self.packages.${system}.site-demo.overrideAttrs (
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
                  cp "${valkyrie-font}/WOFF2/OT-family/Valkyrie-OT/"*.woff2 fonts
                  cp "${valkyrie-font}/concourse-index/WOFF2/concourse_index_regular.woff2" fonts
                ''
                + prevAttrs.buildPhase;
            }
          );

          default = self.packages.${system}.rednoise;

          html-shim = pkgs.buildTypstPackage {
            pname = "html-shim";
            version = "0.1.0";
            src = ./typst/pkgs/html-shim/0.1.0;
          };

          typst-html-wrapper = pkgs.writeShellScriptBin "typst-html-wrapper" ''
            ${pkgs.lib.getExe typst} compile "$@" --features html --format html - - | head -n -2 | tail -n +8
          '';
        };

        apps =
          let
            preview-drv =
              withFonts:
              let
                siteFiles =
                  if withFonts then self.packages.${system}.site-full else self.packages.${system}.site-demo;
                caddyfile = pkgs.writeText "Caddyfile" ''
                  :8000 {
                      root * ${siteFiles}
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
              drv = preview-drv false;
            };

            # only works if you have access to my private repo containing licensed fonts
            preview-full = flake-utils.lib.mkApp {
              drv = preview-drv true;
            };
          };
      }
    );

  nixConfig = {
    extra-substituters = [
      "https://cache.iog.io"
      "https://luminite.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "luminite.cachix.org-1:+VgO/GJMmqsp4U79+QFle7TtEwT8LrJXPiImA8a3a3o="
    ];
    allow-import-from-derivation = "true";
  };
}
