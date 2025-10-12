#import "@preview/html-shim:0.1.0": *

#show: html-shim

#html.elem("p", attrs: (class: "prose-xl lg:prose-2xl"))[
  #smallcaps(all: true)[Greetings. I'm Youwen]. I study math and hack on computers at
  #link("https://ucsb.edu")[UC Santa Barbara].
]

// #webimg(
//   "/static/img/sunset.jpg",
//   "ucsb campus point sunset",
//   extraImgClass: "max-h-[200px] w-full object-cover h-[200px]",
// )
#html.elem(
  "div",
  attrs: (
    class: "bg-gradient-to-tr from-love to-foam w-full rounded-md h-40 bg-[length:200%_auto] animate-gradient-move",
  ),
  "",
)

I'm a member of the
#link("https://www.mit.edu/~ajzd/opencompute/")[MIT OpenCompute Laboratory]
and benevolent dictator at #link("https://functor.systems")[functor.systems].

Here is my #link("https://github.com/youwen5")[GitHub],
#link("/transcript")[university transcript], #link("/cv")[CV/resume], and
#link("/static/img/cat_babies.jpg")[a picture of my cats].

I am interested in the #link("https://ncatlab.org/nlab/show/nPOV")[#emph[n]POV]
and how we can apply higher structures to solve hard problems. In general, I
prefer to use
#link("https://www.gnu.org/philosophy/free-sw.html")[free-as-in-freedom
  software]. I developed
#link("https://code.functor.systems/functor.systems/functorOS")[functorOS], an
experimental NixOS-based Linux distribution---among other free software contributions.

I occasionally attend hackathons for fun. Most recently, I won the grand prize
at #link("https://hackmit.org/")[HackMIT 2025]. This year I am organizing
#link("https://sbhacks.com/")[SB Hacks], the headliner hackathon of UC Santa
Barbara.

In my spare time, I play guitar and spend too much money on guitar pedals. I
listen to a lot of #link("/misc/fav-songs")[music].

See #link("/about")[about] for more about myself, or #link("/now")[now] for
what I'm up to right now. Or explore the other pages on this website.

// #blockquote(attribution: [--- #link(
//     "https://en.wikiquote.org/wiki/Linus_Torvalds",
//   )[Linus Torvalds]])[
//   And I am not a visionary. I do not have a five-year plan. I'm an engineer.
//   And I think it’s really---I mean---I'm perfectly happy with all the people
//   who are walking around and just staring at the clouds and looking at the
//   stars and saying, "I want to go there." But I’m looking at the ground, and I
//   want to fix the pothole that’s right in front of me before I fall in. This is
//   the kind of person I am.
// ]

#blockquote(attribution: [--- #link(
    "https://johncarlosbaez.wordpress.com/2015/03/27/spivak-part-1/",
  )[David Spivak]])[
  Is the world alive, is it a single living thing? If it is, in the sense I
  meant, then its primary job is to survive, and to survive it'll have to make
  decisions. So there I was in my living room thinking, "oh my god, we’ve got to
  steer this thing!"
]

#show heading.where(level: 1): it => {
  html.elem("h2", attrs: (class: "!text-foreground"), it.body)
}
= Recently

#html.elem("p", attrs: (
  class: "text-sm text-subtle not-prose",
))[#smallcaps[RSS] feed coming soon!]

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

#html.elem("div", {
  update(date: "Aug 31, 2025", href: "/writing/anatomy-of-a-nixos-module", {
    icon(name: "code")
    [Explainer: the anatomy of a NixOS module]
  })
  update(date: "May 19, 2025", href: "/math/three-isomorphism-theorems", {
    icon(name: "newspaper")
    [Three isomorphism theorems in linear algebra]
  })

  update(
    date: "May 12, 2025",
    href: "/writing/parallelizing-this-website-for-free",
    {
      icon(name: "code")
      [Parallelizing this website for free]
    },
  )

  update(
    date: "May 10, 2025",
    href: "/writing/doing-web-development-in-typst",
    {
      icon(name: "code")
      [Doing web development in Typst]
    },
  )
})

= Photos

#html.elem("p", attrs: (
  class: "text-sm text-subtle",
))[I recently won a Nikon D7500 DSLR at HackMIT so hopefully I'll be posting more in the near future!]

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
      [Read my code on GitHub]
    })

    entry(href: "https://code.functor.systems/youwen", {
      icon(name: "git-branch")
      [Read my code on code.functor.systems]
    })

    entry(href: "https://bsky.app/profile/youwen.dev", {
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
