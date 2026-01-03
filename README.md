<p align="center"><a href="https://web.youwen.dev"><img src="https://web.youwen.dev/static/logo/button.png"></a></p>

# web.youwen.dev

This is my personal site. It is built using a rather hacked version of the
[Hakyll](https://jaspervdj.be/hakyll/) system, a static site generation
framework configured using the [Haskell](https://www.haskell.org/) language.

You can view the site at [web.youwen.dev](https://web.youwen.dev), deployed using
GitHub pages and cached through Cloudflare's CDN.

## tech stack

### build time

- Haskell
    - [Hakyll](https://jaspervdj.be/hakyll/) (the static site generator library I use)
    - [blaze](https://hackage.haskell.org/package/blaze-html) (an HTML combinator library I use for templating)
    - [clay](https://hackage.haskell.org/package/clay) (CSS preprocessor as a Haskell eDSL)
    - [pandoc](https://pandoc.org/) (this one needs no introduction)
    - [LiquidHaskell](https://ucsd-progsys.github.io/liquidhaskell/) (a highly experimental theorem prover which refines Haskell types using logical predicates to guarantee correctness, developed at UCSD)
- Nix
- [Typst](https://typst.app)

### run time

- HTML
- CSS (tailwind)
- JavaScript (almost none, soon to become PureScript)

## hacking

(only works on Linux because I’m lazy.)

Install [nix](https://nixos.org/), then run this to compile the SSG binary,
which you can run with `result/bin/rednoise watch` for a hot reloading server.
Here you can hack on the Typst source files to edit the content without
recompiling everything.

```sh
nix build
```

To run a local preview server (not hot reloading) of the production website (sans the fonts),

```sh
nix run
# server will run at localhost:8000
```

To get a development environment,

```sh
nix develop
```

Or you can `direnv allow`, if you have it. A pre-commit hook will also be
installed automatically. Inspect `justfile` for useful scripts.

Before submitting a PR run all Haskell tests, formatting checks, lints, etc, using

```sh
nix build .#checks.x86_64-linux.pre-commit-check
```

Note that `nix flake check` always fails due to `haskell.nix` IFD jank so we
have to run the `pre-commit-check` explicitly, which bundles all other checks.

<!-- ## contrib -->
<!---->
<!-- If for some reason you want to open a PR (to fix a bug, typo, etc.), see -->
<!-- [CONTRIBUTING.md](./CONTRIBUTING.md) for technical details and documentation. I -->
<!-- also accept suggestions, comments, criticisms, etc. via email. -->

## license

Most _markup_ content (primarily in Typst files) is CC-BY-SA-4.0. The rest
(that is, everything not covered by the Creative Commons license), including
but not limited to logical code units, is GPL3 licensed. This includes any
Typst _code_ that does not contain useful content (i.e. prose), but rather is
used for programming purposes.

<!-- This repository is an experiment with rewriting my personal website using -->
<!-- Hakyll. Originally, I had written my own static site generator in Rust, called -->
<!-- Epilogue, with the express goal of using Typst's HTML export to generate all -->
<!-- the pages. -->
<!---->
<!-- 9 months later, at the [functor.systems winter -->
<!-- hackathon](https://code.functor.systems/functor.systems/-/projects/3), we -->
<!-- figured out how to write a Typst compiler for the -->
<!-- [Hakyll](https://jaspervdj.be/hakyll/) system, which is a static site -->
<!-- generator _framework_ written in Haskell, wherein you specify build rules in a -->
<!-- Haskell eDSL. This allowed the integration of the Typst rendering from Epilogue -->
<!-- into a fully-featured static site generation infrastructure. This mostly -->
<!-- obviated the need for my own SSG system and I began looking into porting my -->
<!-- whole website to Hakyll and Haskell. I began by forking -->
<!-- [q9i/monadic](https://code.functor.systems/q9i/monadic), which was where we -->
<!-- originally developed the Typst-Hakyll integration, and the `liquidhaskell` -->
<!-- integration, but it has since diverged quite a bit, and, dare I say, become a -->
<!-- bit more advanced than even `monadi.cc`. -->
<!---->
<!-- After a few days of hacking, I have mostly succeeded, porting my website almost -->
<!-- 1:1 to Hakyll. This has allowed me to leverage the features of Hakyll to -->
<!-- trivially build blog features like RSS feeds and automatic feed generation, -->
<!-- amongst other things, which were nontrivial features that would have required -->
<!-- significant development effort in Epilogue that I had been putting off. -->
<!---->
<!-- Along the way, I also replaced the Hakyll HTML templating system with -->
<!-- [blaze-html](https://hackage.haskell.org/package/blaze-html), an HTML -->
<!-- combinator library for Haskell. The motivation for this was inspired by my use -->
<!-- of the [hypertext](https://crates.io/crates/hypertext) crate in Epilogue -->
<!-- rather than a traditional HTML templating system, which implemented HTML -->
<!-- templating as a Rust macro. I really liked the fact that I could program the -->
<!-- HTML template in the exact same language the rest of the project was written -->
<!-- in, so I integrated `blaze-html` into Hakyll, replacing the usual HTML -->
<!-- templates. Due to the power and expressiveness of Haskell, `blaze-html` is -->
<!-- simply implemented as a set of combinators in Haskell itself, without -->
<!-- metaprogramming (more specifically, as a monad). The CSS is also slated to be -->
<!-- written in the CSS monad, from -->
<!-- [clay](https://hackage.haskell.org/package/clay), a CSS preprocessor which is -->
<!-- implemented as a Haskell eDSL similar to `blaze-html`. -->
<!---->
<!-- And all of this Haskell development has been done with the help of -->
<!-- [LiquidHaskell](https://ucsd-progsys.github.io/liquidhaskell/) (LH), which -->
<!-- _refines_ Haskell's types with logical predicates to provide guarantees about -->
<!-- the code. In some sense, the behavior of this website has been checked by a -->
<!-- theorem prover. -->
<!---->
<!-- Finally, I also developed a system for piping data from Hakyll _back_ into -->
<!-- Typst, which allows the Typst document to dynamically generate data based on -->
<!-- the context passed in from Hakyll, for instance, to create an automatically -->
<!-- generated list of recent posts on the homepage. -->
<!---->
<!-- Once the final finishing touches are placed, the entirety of -->
<!-- [youwen5/web](github.com/youwen5/web) will be replaced by the contents of this -->
<!-- repository, retiring Epilogue for good. -->
<!---->
<!-- Once again, all of these efforts were done within the 2-week long -->
<!-- [functor.systems winter 2025 -->
<!-- hackathon](https://code.functor.systems/functor.systems/-/projects/3). -->
