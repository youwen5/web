{ pkgs, rustToolchain }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    taplo.enable = true;
    rustfmt.enable = true;
    rustfmt.package = rustToolchain;
    prettier.enable = true;
    prettier.settings = builtins.fromJSON (builtins.readFile ../.prettierrc);
    typstyle.enable = true;
  };

  settings.global.excludes = [
    ".direnv/*"
    ".envrc"
    "dist/"
    "pnpm-lock.yaml"
    "web-components/pnpm-lock.yaml"
    ".epilogue/"
  ];
}
