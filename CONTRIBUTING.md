# Contributing

Hey! If for some reason you want to spin up a local copy of this website, e.g.
to hack on it, fix a typo/bug, understand the code, whatever, this is the right
place to be! I keep this document updated on a best-effort basis.

## Brief tour of the files

- [`./routes`](./routes): the content of the site. The structure of the website
  mirrors this directory.
- [`./src`](./src): the Rust library that powers the static site generator.
- [`./src/bin`](./src): the source code for the actual website, i.e. CLI and other things.
- [`./src/bin/templates`](./src/bin/templates): HTML templates for the various pages and components, written as Rust macros.
- [`./typst`](./typst): support files for Typst that smooth over the experimental HTML export.
- [`./public`](./public): static assets.
- [`./web`](./web): support `pnpm` project building web assets, mainly for running TailwindCSS and generating the stylesheet. No JavaScript is shipped with the site at this time, but this is where it would go.

## By the way

If you just want to edit some text, you don't actually need to build the whole
site. Just go dig around in [routes](./routes) until you find the file with
the content (the directory structure mirrors the website structure), then edit
it, and send a PR. Otherwise, read on.

## Epilogue

You may have seen scattered references around my site about a thing called
`epilogue`.

`epilogue` is a Rust _library_ for writing static site generators centered around
Typst. It is not a batteries-included unified program controlled by
configuration files like e.g. Hexo, Jekyll, etc. It is somewhere in between
Hakyll and a more traditional site generator. It provides abstractions for
generating static pages, but requires the user to set up a Rust project and
describe the _rules_ for building their site in Rust.

For now I am not planning to release it as a standalone library because the
user experience is not great. However I take care to separate the crate logic
from the site-specific logic and may release it in the future once it is
polished.

HTML templates are written using the `hypertext` crate, using either the
`maud!` or `rsx!` macros (whichever you prefer). Or you could write HTML in
Rust strings if you're mentally deranged.

### Note about the fonts

This site uses the [Valkyrie](https://mbtype.com/fonts/valkyrie/buy.html)
typeface designed by Matthew Butterick, which, importantly, is _not_ a free
font. I paid for this professional font and I am licensed to use it. However, I
cannot distribute it with the source code.

Therefore, `nix build` will _not_ fetch these font files, and the locally built
artifacts will not contain them. (To build the actual site, I have a derivation
that overrides and adds a line to copy the fonts over from a private GitHub
repository. So we still have perfect reproducibility.)

## Local build instructions

### Instructions

Currently development is only possible on Linux. This is because the system
directories Typst uses on macOS are slightly different and I don't care enough
to fix it right now.

We use [nightly
Rust](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html) in order to
farm clout amongst Rustaceans. (The nightly Rust compiler is required for [the nightly Exit Status error](https://doc.rust-lang.org/std/process/struct.ExitStatus.html)).

A `rust-toolchain.toml` file is provided on a
best-effort basis but the source of truth for the Rust compiler and tooling
version is whatever version is pinned by `fenix` in `flake.lock`.

You need **either of the following**:

- Nightly Rust toolchain as specified in `rust-toolchain.toml`, pnpm, just, the Typst CLI in your $$PATH$, and optionally Caddy for previewing
- Just the Nix package manager

I highly recommend you use Nix as `nix develop` can obtain all the tools listed
above automatically.

#### With Nix:

As mentioned above, some of fonts in this website are not free. They are
[Valkyrie](https://practicaltypography.com/valkyrie.html) and [Concourse
Index](https://practicaltypography.com/concourse-index.html), designed by
Matthew Butterick. However you don't really need the fonts to hack on the code,
so it is not necessary to obtain them. The commands below should work for you,
but the local site you build will obviously not have the right fonts available.

Building a production bundle of the site files:

```nix
nix build
```

The site files will be made available in `result/dist`.

#### With local tools (for hacking):

If doing local development, directly invoking the tools locally is highly
recommended because `nix build` is quite slow. I use
[just](https://just.systems/), a command runner, to manage build scripts and
the like.

```sh
just fresh-init # just once, installs pnpm dependencies and sets up the environment

just # compile and build the site to dist/
```

You need the tools mentioned previously (`pnpm`, `just`, `typst`, etc), but if
you have Nix, you can run `nix develop` and they will be made available
automatically (this is highly recommended).

This will spin up a development server (not hot reloading, though) at `localhost:8000`:

```sh
just preview
```
