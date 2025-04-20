{
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    taplo.enable = true;
    rustfmt.enable = true;
    yamlfmt.enable = true;
  };

  settings.global.excludes = [
    ".direnv/*"
    ".envrc"
  ];
}
