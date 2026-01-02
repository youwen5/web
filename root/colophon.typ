---
title: "Colophon"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

This site was built with my custom static generator called
#link("/software/epilogue")[Epilogue]. It was written in Rust, and its unique
feature is that it uses #link("https://typst.app/")[Typst] as a scriptable
markup language instead of something like Markdown. It outputs fully rendered
organic fair-trade #smallcaps[html] that gets shipped straight from
farm-to-user. No JavaScript virtual #smallcaps[dom] or frameworks here (the
only JavaScript I ship is `prism.js` and #link("/privacy")[analytics]).

Styling is done with #link("https://tailwindcss.com/")[Tailwind],
an insane way to do #smallcaps[css], saved only by the fact that it is better
than every other way to do #smallcaps[css]. The #smallcaps[html] templates are
written as #link("https://maud.lambda.xyz/")[maud] macros in Rust (which means
the Rust compiler is essentially my templating engine). The
#link("https://crates.io/crates/hypertext")[hypertext] crate's `maud!`
implementation is used for efficient rendering.

#dinkus

The sans-serif typeface is
#link("https://fonts.google.com/specimen/Source+Sans+3")[Source Sans 3]. The
typeface used for both body text and headings is
#link("https://practicaltypography.com/valkyrie.html")[Valkyrie], a
professional font designed by Matthew Butterick. Much of this site's web design
is informed and inspired by his
#link("https://practicaltypography.com/")[Practical Typography]. Thank you Mr.
Butterick!

The color scheme is #link("https://rosepinetheme.com/")[Rosé Pine], in the
#smallcaps[dawn] variant for light mode (with a pure white background because
I'm not a fan of the cream) and #smallcaps[main] variant for dark mode.

I've owned this domain and had a personal website since 2023. Here is my
#link("https://old.youwen.dev/")[old website], which I'll keep online for
archival purposes until it becomes too much work to do so.
