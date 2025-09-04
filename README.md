<p align="center"><a href="https://web.youwen.dev"><img src="https://web.youwen.dev/static/logo/button.png"></a></p>

# web.youwen.dev

This is my personal site. It is built using a custom site generator I
implemented in Rust, located in this repository. It generates all of its pages
using [Typst](https://typst.app).

You can view the site at [web.youwen.dev](https://web.youwen.dev), deployed using
GitHub pages and cached through Cloudflare's CDN.

## tech stack

### build time

- Rust
- Nix
- [Typst](https://typst.app)

### run time

- HTML
- CSS (tailwind)
- JavaScript (almost none)

## hacking

(only works on Linux because I’m lazy.)

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

To get a development environment,

```sh
nix develop
```

Or you can `direnv allow`, if you have it. A pre-commit hook will also be
installed automatically.

If you decide to bring your own Rust toolchain, note that **nightly Rust is
required** due to use of unstabilized features.

Also note that **Typst latest git** is required due to use of bleeding edge HTML export features.

Before submitting a PR run all Rust tests, formatting checks, lints, etc, using

```sh
nix flake check
```

## contrib

If for some reason you want to open a PR (to fix a bug, typo, etc.), see
[CONTRIBUTING.md](./CONTRIBUTING.md) for technical details and documentation. I
also accept suggestions, comments, criticisms, etc. via email.

## license

Most _markup_ content (primarily in Typst files) is CC-BY-SA-4.0. The rest
(that is, everything not covered by the Creative Commons license), including
but not limited to logical code units, is GPL3 licensed. This includes any
Typst _code_ that does not contain useful content (i.e. prose), but rather is
used for programming purposes.
