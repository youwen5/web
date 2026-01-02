{ pkgs }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    prettier.enable = true;
    prettier.settings = builtins.fromJSON (builtins.readFile ../.prettierrc);
    typstyle.enable = true;
    fourmolu.enable = true;
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
