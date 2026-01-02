---
title: "Doing web development in Typst"
published: 2025-05-10
---

// date: datetime(day: 10, year: 2025, month: 5),
// location: "Santa Barbara, California",
// enable-comments: true,

#import "@preview/html-shim:0.1.0": *

#show: html-shim

Over the past month I've been experimenting with writing a website
(specifically, this website) using #link("https://typst.app/")[Typst], a
document preparation system and markup language. Most people know Typst as a
LaTeX replacement, but it can also generate #smallcaps[html]. I've found that
it can probably act as a replacement for Markdown/Pandoc based static site
generator systems too.

= How

There are other pages on this site explaining this, but essentially I wrote a
tiny #link("/epilogue")[static site generator] using Rust that calls the Typst
#smallcaps[cli] to produce #smallcaps[html], and then I embed it into a
template (that contains navigation widgets, footer, `<head>`, etc). Each page is a Typst
source file. The Typst source code for each page can emit metadata, similar to
how #smallcaps[yaml] frontmatter works in Markdown. I implemented it so the
syntax for setting metadata on a web page is really similar to setting up a
typical Typst document template. For example, here's the metadata for this
page:

```typst
#show: html-shim.with(
  date: datetime(
    day: 10,
    year: 2025,
    month: 5,
  ),
  location: "Santa Barbara, California",
  title: "Doing web development in Typst",
  enable-comments: true,
)
```

Typst #smallcaps[html] export is experimental, so I wrote this
#link("https://github.com/youwen5/web/blob/main/typst/lib/html-shim/0.1.0/html-shim.typ")[#smallcaps[html]
  shim] that makes stuff work right on the web (like smallcaps, for example), renders math
properly, and implements the aforementioned metadata system.

= Ergonomics

Obviously writing content is super natural. You can just type plaintext
paragraphs, and Typst will render it with nice semantic #smallcaps[html]. With
a little hacking, I got features like smallcaps working in the browser. And native math support is nice:
$
  integral_(-infinity)^infinity e^(-x^2) dif x = sqrt(pi)
$
But doing more complicated stuff is possible too. For example, those widgets on
the #link("/")[main page] were written in pure Typst.

#html.elem("div", attrs: (
  class: "grid grid-cols-1 md:grid-cols-2 gap-6 font-sans font-light text-love",
))[
  #let double-entry(body) = {
    html.elem("div", attrs: (class: "border-b-love border-b-1 py-1"), body)
  }

  #let single-entry(body) = {
    html.elem("div", attrs: (class: "border-b-love border-b-1"), body)
  }

  #let location-entry(area: "nowhere", country-or-state: "now here") = {
    html.elem(
      "div",
      attrs: (
        class: "border-b-love border-b-1 inline-flex justify-between w-full gap-2",
      ),
    )[
      #html.elem("span", area)
      #html.elem("span", country-or-state)
    ]
  }

  #html.elem("div", attrs: (class: "space-y-2 prose-lg"))[
    #double-entry[
      B.S. Mathematics \
      University of California, Santa Barbara
    ]
    #double-entry[
      B.S. Computer Science \
      University of California, Santa Barbara
    ]
  ]
  #html.elem("div", attrs: (class: "space-y-[7.5px] prose-lg"))[
    #location-entry(area: [in Santa Barbara], country-or-state: [
      #smallcaps(all: true)[California, USA]
    ])
    #location-entry(area: [near San Francisco], country-or-state: [
      #smallcaps(all: true)[California, USA]
    ])
    #location-entry(area: [previously near Salt Lake City], country-or-state: [
      #smallcaps(all: true)[Utah, USA]
    ])
    #location-entry(area: [previously in Shanghai], country-or-state: [
      #smallcaps(all: true)[China]
    ])
  ]
]

It turns out that having access to a full programming language is really nice.
To produce the above, I defined a `location-entry` function like this:


```typst
#let location-entry(area: "nowhere", country-or-state: "now here") = {
  html.elem(
    "div",
    attrs: (
      class: "border-b-love border-b-1 inline-flex justify-between w-full gap-2",
    ),
  )[
    #html.elem("span", area)
    #html.elem("span", country-or-state)
  ]
}
```

Then I can create a `div`, and then call my function repeatedly to populate it.
Kind of like a React component, without the pain and complexity. Notice that the
#smallcaps[css] can all be done inline using Tailwind (which was surprisingly
easy to set up).
```typst
#html.elem("div", attrs: (class: "space-y-[7.5px] prose-lg"))[
  #location-entry(
    area: [in Santa Barbara],
    country-or-state: [
      #smallcaps(all: true)[California, USA]
    ],
  )
  #location-entry(
    area: [near San Francisco],
    country-or-state: [
      #smallcaps(all: true)[California, USA]
    ],
  )
  #location-entry(
    area: [previously near Salt Lake City],
    country-or-state: [
      #smallcaps(all: true)[Utah, USA]
    ],
  )
  #location-entry(
    area: [previously in Shanghai],
    country-or-state: [
      #smallcaps(all: true)[China]
    ],
  )
]
```


Obviously you can't create any interactive components like a fully fledged web
framework, but you get this middle ground between the austerity and ease of
writing of Markdown, and the power of a templating system. (I am aware of
#smallcaps[#link("https://mdxjs.com/")[mdx]], but then you have to use a
fully-fledged web framework #emoji.face.nausea.) It's surprisingly nice to use,
despite #smallcaps[html] export being a total afterthought in Typst right now
(which, again, is 99% a document preparation system, not a static site
generator).

Plus, I write all my documents and notes in Typst too. Now I can write web
pages (like this one) with the same syntax, and share content.
