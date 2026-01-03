---
title: "Colophon"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

= Type

The primary typeface used across most body text, headings, the wordmark, etc is
#link("https://practicaltypography.com/valkyrie.html")[Valkyrie], a typeface
designed by #link("https://matthewbutterick.com/")[Matthew Butterick], whose
#link("https://practicaltypography.com/")[Practical Typography] influenced the
design of this website.

The sans-serif font is
#link("https://fonts.adobe.com/fonts/source-sans-3")[Source Sans 3], a free
font from Adobe designed by Paul D. Hunt.

= Design

The color scheme is #link("https://rosepinetheme.com/")[Rosé Pine], in the
#smallcaps[dawn] variant for light mode (with a pure white background because
I'm not a fan of the cream) and #smallcaps[main] variant for dark mode.

= Tech

This site was built with the static site generator library called
#link("https://jaspervdj.be/hakyll/")[Hakyll]. It's configured with a Haskell
eDSL, and insanely hackable. It uses
#link("https://hackage.haskell.org/package/blaze-html")[blaze-html], an HTML
combinator library, for templating, and verifies behavior with
#link("https://ucsd-progsys.github.io/liquidhaskell/")[LiquidHaskell], an
interactive theorem prover that integrates into Haskell which refines its types
with logical predicates to enforce properties at compile time. All of the pages
are written in the #link("https://typst.app/")[Typst] language, through its
HTML output feature.

There's a little more history to my website, actually. Originally, this site
was powered by my own static site generation system called "Epilogue" which I
wrote in Rust, implementing low level details by hand. It used a
#link("https://github.com/vidhanio/hypertext")[Rust macro] for HTML templating,
so you could write template logic in the exact same language as the rest of the
website, and keep the type system around, too.

The main reason I wrote my own static site generator was to use
#link("https://typst.app/")[Typst] as the primary markup language for writing
pages. Typst is essentially a LaTeX replacement that implements a rich markup
language kind of like Markdown, but with a fully featured scripting system
builtin, no templating engine required. It primarily targets PDFs, but also
does HTML export. For example, the #link("https://web.youwen.dev/cv/")[CV] is
actually the exact same Typst source file under the hood, compiled to both HTML
and PDF targets.

Around a year after the initial website deployment using Epilogue I had still
not implemented feed generation, tagging, and other standard SSG features,
which was suboptimal. I had spent the past year climbing the latter of
mathematical abstraction, so rather than waste time implementing such trivial
features, I decided to try my hand once again at actual Haskell development and
began looking into the Hakyll system.

It turns out that Hakyll is really, really good. It's less of an SSG itself and
more of an SSG library that you use to implement your own custom site
generator. By default, it uses traditional HTML templates, but I was easily
able to write a custom "compiler" to integrate
#link("https://hackage.haskell.org/package/blaze-html")[blaze-html], an HTML
combinator library for Haskell that allowed me to write the HTML in Haskell
itself. This was similar to the Rust macro templating system I had before,
except Haskell is so expressive that metaprogramming is not even necessary and
it could be implemented as a straightforward monad.

But the crux of all of this was that the Typst compilation technology was still
easily possible. See, Hakyll does not impose any opinions on what inputs go
into the website and what outputs come out. It provides a Pandoc compiler by
default, but you can replace this with anything you want, so I wrote a Typst
compiler that integrated seamlessly. This means that Typst is supported just as
well as in Epilogue, but you get a slew of nice features for free, like
#link("/atom.xml")[feed generation]. I can also write, say, Markdown or rst or
even Literate Haskell in some other page and have that rendered just as easily
by writing a custom rule, so I'm not locked into Typst.

#dinkus

I've owned this domain and had a personal website since 2023. Here is my
#link("https://old.youwen.dev/")[old website], which I'll keep online for
archival purposes until it becomes too much work to do so.
