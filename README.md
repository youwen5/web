# About

This is my personal site. It is built using a custom site generator I
implemented in Rust called `luminite`, located in this repository.

You can view the site at [web.youwen.dev](https://web.youwen.dev), deployed to
GitHub pages using Nix.

Unlike most site generators, it uses the typesetting system Typst as the
primary markup language rather than Markdown. Typst is a system like LaTeX
mainly for producing beautiful (PDF) documents, but it can also do HTML output!
This site generator uses Typst to generate HTML markup which is then inserted
into HTML templates (written as Rust macros) to produce the final site.

## Build instructions

You need either a Rust toolchain or the Nix package manager. To hack on the
code, a Rust toolchain is highly recommended in addition to Nix.

With Nix:
```sh
nix build
```

The site will be built in `result/`.

With Cargo:
```sh
cargo run --release -- build
```

The site will be built in `dist/`.

## Luminite

`luminite` is a Rust _library_ for writing static site generators centered around
Typst. It is not a batteries-included unified program controlled by
configuration files like e.g. Hexo, Jekyll, etc. It is somewhere in between
Hakyll and a more traditional site generator. It provides abstractions for
generating static pages, but requires the user to set up a Rust project and
describe the _rules_ for building their site in Rust.

I am tentatively planning to move it into a standalone crate once it is mature
enough. For now I am dogfooding it in this repository (with care to separate
the crate logic from the site-specific logic).

Templates are written using the `hypertext` crate, using either the `maud!` or
`rsx!` macros (whichever you prefer). Or you could write HTML in Rust strings
if you're mentally deranged.

If you are just looking for a way to write on the web using Typst, consider
[shiroa](https://github.com/Myriad-Dreamin/shiroa), which produces books like
mdBook but written in Typst instead of markdown. If you want a faithful
reproduction (i.e. having the Typst rendering engine output SVGs into the
browser) of Typst documents in the web, consider
[typst.ts](https://myriad-dreamin.github.io/typst.ts/).

Most development happens on the `dev` branch.
