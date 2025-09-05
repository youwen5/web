#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(title: "About")

#let chinese-name = html.elem("span", attrs: (lang: "zh-Hans"), [佑文])

#dropcap[
  W#smallcaps[elcome] to my hypertext garden on the World Wide Web. There are
  many like it---but this one is mine. I'm Youwen, and I
  #link("/software/epilogue")[designed this website] myself, by hand, down to
  the last pixel of margin in paragraph headings. Amongst its pages are a
  mosaic of scattered thoughts, notes, essays, and fragments of my life.
]

I currently study math and computer science at the
#link("https://www.ucsb.edu/")[University of California, Santa Barbara.]
Favorite pastimes include watching classic movies and TV shows, playing guitar
(poorly), video games, tinkering of all sorts, and long walks along the beach.

I'm originally from Shanghai, China. My second hometown is Leiyang City
(耒阳市), in Hunan Province, China---the birthplace of Cai Lun, the inventor of
paper.

I lived in the state of Utah for a few years as a kid, before moving to the San
Francisco Bay Area. I attended 6 different elementary schools, 1 middle school,
and 2 high schools.

#dinkus

Lately, besides hacking on random projects, my time has been mostly split
between managing #link("https://functor.systems")[functor.systems], a hacker collective
building cool stuff, and working on a few hardware/software projects with
the #link("https://www.mit.edu/~ajzd/opencompute/")[MIT OpenCompute Lab].

I like programming, somewhat. I hold the view of the
#link("https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-7.html")[Wizard
  Book] #footnote[aka the legendary _Structure and Interpretation of Computer
    Programs_] that programming is _procedural epistemology_---the act of learning
and understanding enough about a problem to write code to solve it. The process
of writing and iterating on code itself _is_ the valuable portion. In contrast,
the final code produced to solve a problem is merely a _side effect_ of the
process of discovering enough about the problem to write it in the first place.
In that sense, I despise _coding_, the act of translating a known problem and
solution into procedures for a computer. Coding is best left to so-called _code
  monkeys_.

I'm an adherent of the #link(newtab: true, "https://ncatlab.org/nlab/show/nPOV")[#emph[n]POV]
of the #link("https://ncatlab.org/nlab/show/HomePage")[#emph[n]Lab]: #quote[the
  observation that homotopy theory/algebraic topology, (homotopy) type theory,
  (higher) category theory and (higher) categorical algebra have a plethora of
  useful applications.]

#link("/static/img/iuselinuxbtw.jpg", internal: true, newtab: true)[By the way], I use NixOS. See
#link("/tools")[this page] to hear all about my neurotic software choices.
