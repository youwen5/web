# About

This is my personal site. It is built using a custom site generator I
implemented in Rust, located in this repository.

You can view the site at [web.youwen.dev](https://web.youwen.dev), deployed using
GitHub pages.
Unlike most site generators, it uses the typesetting system
[Typst](https://typst.app) as a markup language rather than something like
Markdown. Typst is a system like LaTeX mainly for producing beautiful (PDF)
documents, but it can also do HTML output! This site generator uses Typst to
generate HTML markup which is then inserted into HTML templates (written as
Rust macros) to produce the final site.

## Building

(This site can only be built on Linux because I am lazy.)

Install [nix](https://nixos.org/), then
```sh
nix build
# site files will be built in `./result/dist`
```

To run a local preview server (not hot reloading),
```sh
nix run .#preview
# server will run at localhost:8000
```

## Contrib

If for some reason you want to open a PR (to fix a bug, typo, etc.), see
[CONTRIBUTING.md](./CONTRIBUTING.md) for technical details and documentation. I
also accept suggestions, comments, criticisms, etc. via email.

## License

Most _markup_ content (primarily in Typst files) is CC-BY-SA-4.0. The rest
(that is, everything not covered by the Creative Commons license), including
but not limited to logical code units, is GPL3 licensed. This includes any
Typst _code_ that does not contain useful content (i.e. prose), but rather is
used for programming purposes.
