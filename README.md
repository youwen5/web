# About

This is my personal site. It is built using a custom site generator I
implemented in Rust called [`luminite`](#Luminite), located in this repository.

You can view the site at [web.youwen.dev](https://web.youwen.dev), deployed using
GitHub pages.

Unlike most site generators, it uses the typesetting system Typst as the
primary markup language rather than Markdown. Typst is a system like LaTeX
mainly for producing beautiful (PDF) documents, but it can also do HTML output!
This site generator uses Typst to generate HTML markup which is then inserted
into HTML templates (written as Rust macros) to produce the final site.

This site is deployed reproducibly with Nix. With Nix installed, `nix run
.#preview` will build the site locally, with the exact same files as the
version in production, and spin up a preview server at `localhost:8000`.

## Brief tour

- [`./routes`](./routes): the content of the site. The structure of the website
  mirrors this directory.
- [`./src`](./src): the Rust library that powers the static site generator.
- [`./src/bin`](./src): the source code for the actual website, i.e. CLI and other things.
- [`./src/bin/templates`](./src/bin/templates): HTML templates for the various pages and components, written as Rust macros.
- [`./typst`](./typst): support files for Typst that smooth over the experimental HTML export.
- [`./public`](./public): static assets.
- [`./web`](./web): support `pnpm` project building web assets, mainly for running TailwindCSS and generating the stylesheet. No JavaScript is shipped with the site at this time, but this is where it would go.

Here's what we can do so far:

- Given a Typst file, render it to a webpage. For instance, see [this page](https://web.youwen.dev/luminite), rendered entirely from [Typst source](./routes/+luminite.typ).
- Query metadata from Typst files using the `#metadata` function and `typst query`.
- Glob matching routes to templates.
- Modular components, like reusable navbars and the like.


## Build instructions

### Instructions

Currently development is only possible on Linux. This is because the system
directories Typst uses on macOS are slightly different and I don't care enough
to fix it right now.

We use [nightly
Rust](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html) in order to
farm clout amongst Rustaceans. A `rust-toolchain.toml` file is provided on a
best-effort basis but the source of truth for the Rust compiler and tooling
version is whatever version is pinned by `fenix` in `flake.lock`.

Of course if you just want to edit content, you don't need to compile the site
locally. Just edit the [Typst source files](./routes). Otherwise, read on.

You need **either**

- Nightly Rust toolchain as specified in `rust-toolchain.toml`, pnpm, just, the Typst CLI in your $$PATH$, and optionally Caddy for previewing
- Just the Nix package manager

I highly recommend you use Nix as `nix develop` can obtain all the tools listed
above automatically.

#### With Nix:

```nix
nix build
```

The site files will be made available in `result/dist`.

#### With local tools (for hacking):

```sh
just fresh-init # just once

just # compile and build the site to dist/
```

To hack on the code, I highly recommend having the local development tools
available in addition to Nix. If you have Nix, you can run `nix develop` and
they will be made available automatically. Run `just preview` and a live server
will be started at `localhost:8080`. Additional commands are available in the
`justfile`.

The site will be built in `dist/`.

### Note about the font

This site uses the [Valkyrie](https://mbtype.com/fonts/valkyrie/buy.html)
typeface designed by Matthew Butterick, which, importantly, is _not_ a free
font. I paid for this professional font and I am licensed to use it. However, I
cannot distribute it with the source code.

Therefore, `nix build` will _not_ fetch these font files, and the locally built
artifacts will not contain them. (To build the actual site, I have a derivation
that overrides and adds a line to copy the fonts over from a private GitHub
repository. So we still have perfect reproducibility.)

## Luminite

`luminite` is a Rust _library_ for writing static site generators centered around
Typst. It is not a batteries-included unified program controlled by
configuration files like e.g. Hexo, Jekyll, etc. It is somewhere in between
Hakyll and a more traditional site generator. It provides abstractions for
generating static pages, but requires the user to set up a Rust project and
describe the _rules_ for building their site in Rust.

For now I am not planning to release it as a standalone library because the
user experience is not great. However I take care to separate the crate logic
from the site-specific logic and may release it in the future once it is
polished.

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

## License

Most _markup_ content (primarily in Typst files) is CC-BY-SA-4.0. The rest
(that is, everything not covered by the Creative Commons license), including
but not limited to logical code units, is GPL3 licensed. This includes any
Typst _code_ that does not contain useful content (i.e. prose), but rather is
used for programming purposes.
