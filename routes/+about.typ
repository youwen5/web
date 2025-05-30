#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(title: "About")

#let chinese-name = html.elem("span", attrs: (lang: "zh-Hans"), [佑文])

#dropcap[
  W#smallcaps[elcome] to my hypertext garden on the World Wide Web. There are
  many like it---but this one is mine.
]

I’m Youwen, and I #link("/software/epilogue")[designed this website] myself, down to the
last pixel of margin in paragraph headings.

I currently study math and computer science at the
#link("https://www.ucsb.edu/")[University of California, Santa Barbara.]
Favorite pastimes include watching classic movies and TV shows, playing guitar
(poorly), video games, tinkering of all sorts, and long walks along the beach.

I like programming, somewhat. I hold the view of the
#link("https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-7.html")[Wizard
  Book]#footnote[aka the legendary Structure and Interpretation of Computer
  Programs] that programming is _procedural epistemology_---the act of learning
and understanding enough about a problem to write code to solve it. The process
of writing and iterating on code itself _is_ the valuable portion. In contrast,
the final code produced to solve a problem is merely a _side effect_ of the
process of discovering enough about the problem to write it in the first place.
In that sense, I despise _coding_, the act of translating a known problem and
solution into procedures for a computer. Coding is best left to so-called _code
monkeys_.

I’m an adherent of the #link(newtab: true, "https://ncatlab.org/nlab/show/nPOV")[#emph[n]POV]
of the #link("https://ncatlab.org/nlab/show/HomePage")[#emph[n]Lab]: #quote[the
  observation that homotopy theory/algebraic topology, (homotopy) type theory,
  (higher) category theory and (higher) categorical algebra have a plethora of
  useful applications.]

#link("/static/img/iuselinuxbtw.jpg", newtab: true)[By the way], I use NixOS. See
#link("/computing")[this page] to hear all about my neurotic software choices.

#dinkus

= History

I’m originally from Shanghai, China. I lived in the state of Utah for a few
years as a kid, before moving to the San Francisco Bay Area. I attended 6
different elementary schools, 1 middle school, and 2 high schools.

= Math

Broadly speaking the purpose of mathematics is likely to crush the dreams and
self-esteem of young undergraduates. Before going to university I mistakenly
believed that I was an intelligent entity who could think coherent thoughts and
so-on. After a year of studying math I have come to the realization that I am
merely a #link("https://www.goodreads.com/quotes/76608-anyone-who-cannot-cope-with-mathematics-is-not-fully-human")[#quote[tolerable
    subhuman who has learned to wear his shoes, bathe, and not make messes in the
    house.]]

#webimg(
  "https://preview.redd.it/kwp14kysyul41.png?auto=webp&s=25544fd77159edfd1b6276ea2c59a4d6b5c9cfe3",
  "undergrad category theorist",
)

= Computing

I seek to create more _reliable_ and _resilient_ systems. To that end I
contribute to various open source projects that aim to increase reproducibility
and determinism in software systems at scale.

I run a purely functional (in the true mathematical sense) computing
environment that enables the deterministic deployment of software,
configuration, and infrastructure all the way down the stack. This includes
both the system itself, which can never mutate state and must be rebuilt for
modifications to be made, as well as a purely functional userspace, that keeps
programs configured precisely as described and managed transactionally. My text
editor is configured in a Lisp called Fennel and deployed in a purely
functional fashion by Nix.

Additionally, I prefer to work on and with software that respects my freedom.
In fact my M1 Macbook Pro runs an entirely free reverse engineered graphics and
driver stack. All of my computers run a free GNU/Linux operating system.

Key benefits of my approach to computing include:

- fearless hacking: as the system is rebuilt each time it is modified, it can
  simply transactionally rollback to a previous system generation.
- text-based and keyboard driven: by keeping the system entirely deterministic (not just
  technically, but philosophically), I can ditch unwieldy graphical interfaces
  and build a text-centered user experience.
- trustless full source bootstrap:
  secure yourself from malevolent state actors and resist the KTH by
  bootstrapping the entire system from its free source code and a minimal amount
  of binary seeds.
