#import "@preview/html-shim:0.1.0": *

#show: html-shim

#html.elem("p", attrs: (class: "prose-xl lg:prose-2xl"))[
  #smallcaps(all: true)[Greetings. I'm Youwen]. I study math and hack on computers at
  #link("https://ucsb.edu")[UC Santa Barbara].
]

#webimg(
  "/static/img/sunset.jpg",
  "ucsb campus point sunset",
  extraImgClass: "max-h-[200px] w-full object-cover h-[200px]",
)

I'm a member of the
#link("https://www.mit.edu/~ajzd/opencompute/")[MIT OpenCompute Laboratory]
and benevolent dictator at #link("https://functor.systems")[functor.systems].

Here is my #link("https://github.com/youwen5")[GitHub], #link("/transcript")[university transcript], #link("/cv")[CV/resume], and #link("/static/img/cat_babies.jpg")[a picture of my cats].

I am interested in the #link("https://ncatlab.org/nlab/show/nPOV")[#emph[n]POV] and
how we can apply higher structures to solve hard problems. In general, I prefer
to use #link("https://www.gnu.org/philosophy/free-sw.html")[free-as-in-freedom
  software]. I contribute to #link("https://nixos.org")[NixOS] and other
#smallcaps[foss] projects.

In my spare time, I play guitar and spend too much money on guitar pedals. I
also hate coding.

See my #link("/about")[about page] for more about myself, or my
#link("/now")[now page] for what I'm up to right now. Or explore
the other pages on this website.

#blockquote(attribution: [--- #link(
    "https://www.paulgraham.com/top.html",
  )[Paul Graham]])[It's hard to do a really good job on anything you don't think about in the shower.]

#show heading.where(level: 1): it => {
  html.elem("h2", attrs: (class: "!text-foreground"), it.body)
}
= Recently

#let icon(name: "") = {
  html.elem("span", attrs: (class: "my-auto w-[24px]"), lucide-icon(name: name))
}

#let update(date: "", is-link: true, internal: true, href: "", body) = {
  html.elem(
    if is-link { "a" } else { "span" },
    attrs: (
      href: href,
      class: "border-b-foreground border-b-1 py-1 px-1 hover:bg-foreground hover:text-bg w-full w-full font-serif flex justify-between flex-wrap-reverse content-center gap-x-2 gap-y-1 md:gap-4",
    ),
  )[
    #html.elem("span", attrs: (class: "inline-flex gap-3"), body)
    #html.elem("span", attrs: (class: "inline-flex gap-4"))[
      #if date != "" {
        html.elem("span", attrs: (class: "font-light text-lg my-auto"))[
          #smallcaps(all: true, date)
        ]
      }
      #if date == "" {
        if internal {
          icon(name: "move-right")
        } else if is-link {
          icon(name: "external-link")
        }
      }
    ]
  ]
}

#{
  update(date: "May 19th, 2025", href: "/unicode-quotes", {
    icon(name: "newspaper")
    [Stop using the wrong quotes!]
  })
  update(date: "May 19th, 2025", href: "/math/three-isomorphism-theorems", {
    icon(name: "newspaper")
    [Three isomorphism theorems in linear algebra]
  })

  update(
    date: "May 12th, 2025",
    href: "/writing/parallelizing-this-website-for-free",
    {
      icon(name: "code")
      [Parallelizing this website for free]
    },
  )

  update(
    date: "May 10th, 2025",
    href: "/writing/doing-web-development-in-typst",
    {
      icon(name: "code")
      [Doing web development in Typst]
    },
  )
}

= Photos

#let photo-urls = (
  (
    "https://cdn.youwen.dev/IMG_5525.jpeg",
    "Moon over the Pacific, Santa Barbara",
    datetime(day: 11, month: 5, year: 2025),
  ),
  (
    "https://cdn.youwen.dev/sunset-over-berkeley.webp",
    "Sunset over UC Berkeley",
    datetime(day: 2, month: 1, year: 2025),
  ),
  (
    "https://cdn.youwen.dev/dji_fly_20240805_060926_418_1722863474220_photo_optimized.jpeg",
    "Mission Peak, Newark, California",
    datetime(day: 5, month: 8, year: 2024),
  ),
)

#let photo(src, caption, date) = {
  let base-class = "p-1 hover:bg-foreground hover:text-bg space-y-1 group w-48 min-w-48"

  html.elem(
    "a",
    attrs: (
      href: src,
      target: "_blank",
      class: base-class,
    ),
    {
      html.elem("img", attrs: (
        src: src,
        class: "w-full aspect-square lg:aspect-3/4 object-cover !my-1",
        alt: caption,
        loading: "lazy",
      ))
      html.elem("div", attrs: (class: "text-base w-full px-1"), [
        #html.elem(
          "span",
          attrs: (class: "text-sm text-subtle group-hover:text-bg"),
          date.display("[day padding:zero] [month repr:short], [year]"),
        ) \
        #caption
      ])
    },
  )
}


#html.elem(
  "div",
  attrs: (
    class: "overflow-x-auto w-0 min-w-full gap-4 inline-flex flex-nowrap",
  ),
  {
    for elem in (
      photo-urls.map(it => photo(..it))
    ) {
      elem
    }
  },
)

#html.elem(
  "a",
  attrs: (
    href: "/photos",
    class: "p-1 font-serif hover:text-bg hover:bg-foreground border-b-1 border-b-foreground text-foreground decoration-none min-w-full inline-flex justify-between content-center min-h-[50px]",
  ),
  {
    html.elem("span", attrs: (class: "flex gap-2 my-auto"))[
      #icon(name: "camera")
      Full gallery
    ]
    icon(name: "move-right")
  },
)

#show heading.where(level: 1): it => {
  html.elem("h2", attrs: (class: "text-love"), it.body)
}

#html.elem("div", attrs: (id: "contact"), [])
= Contact

#html.elem(
  "div",
  attrs: (class: "font-sans w-full prose-lg"),
  {
    let entry(
      href: "",
      is-link: true,
      newtab: true,
      internal: false,
      body,
    ) = {
      html.elem(
        if is-link { "a" } else { "span" },
        attrs: (
          href: href,
          target: if newtab { "_blank" } else { "" },
          class: "p-1 font-light hover:text-bg hover:bg-love border-b-1 border-b-love text-love decoration-none min-w-full inline-flex justify-between content-center min-h-[50px]",
        ),
        {
          html.elem("span", attrs: (class: "flex gap-2 my-auto"), body)
          if internal {
            icon(name: "move-right")
          } else if is-link {
            icon(name: "external-link")
          }
        },
      )
    }
    entry(href: "/impressum", newtab: false, internal: true, {
      icon(name: "send")
      [Send me electronic mail (preferred)]
    })

    entry(href: "https://matrix.to/#/@youwen:functor.systems", {
      icon(name: "atom")
      [Matrix]
    })

    entry(href: "https://github.com/youwen5", {
      icon(name: "github")
      [See my code on GitHub]
    })

    entry(href: "https://youwen5.bsky.social", {
      icon(name: "origami")
      [Bluesky]
    })

    entry(href: "https://www.instagram.com/youwenw5/", {
      icon(name: "instagram")
      [Instagram]
    })

    entry(href: "https://www.linkedin.com/in/youwen-wu-306221288/", {
      icon(name: "linkedin")
      [LinkedIn]
    })

    entry(is-link: false, {
      icon(name: "brain")
      [Telepathically scribe me over the ethereal plane]
    })
  },
)

= Places

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
      B.S. Mathematics (2028) \
      University of California, Santa Barbara
    ]
    #double-entry[
      B.S. Computer Science (2028) \
      University of California, Santa Barbara
    ]
  ]
  #html.elem("div", attrs: (class: "space-y-[7.33px] prose-lg"))[
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

#html.elem(
  "div",
  attrs: (
    class: "bg-gradient-to-r from-love to-foam w-full rounded-md mt-8 h-24",
  ),
  "",
)
