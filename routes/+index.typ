#import "@luminite/html-shim:0.1.0": *

#show: html-shim

Hey there! Welcome to my corner of the World Wide Web. I tinker with math and
computers at UC Santa Barbara.

Here is my #link("https://github.com/youwen5")[GitHub], #link("/transcript")[university transcript], #link("https://www.last.fm/user/couscousdude")[last.fm], and #link("/static/img/cat_babies.jpg")[a picture of my cats].

I play guitar and spend way too much money on guitar pedals. I also hate
coding.

See my #link("/now")[now page] for what I'm up to right now.

For contact information, see the #link("/impressum")[impressum].

#html.elem(
  "blockquote",
  attrs: (class: "italic border-l-4 border-rose w-fit"),
  [
    #quote[A comathematician is a device for turning cotheorems into ffee.]
    #html.elem(
      "div",
      attrs: (class: "text-end not-italic text-xl"),
      [---#link("https://wiki.haskell.org/Quotes")[The Haskell Wiki]],
    )
  ],
)
