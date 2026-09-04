---
pagetitle: "web.youwen.dev"
title: Youwen Wu >> Welcome Home.
---

#import "@preview/html-shim:0.1.0": *
#import "@preview/based:0.2.0": base64

#show: html-shim

#let encodePhotoData(data) = {
  base64.encode(json.encode(data, pretty: false))
}


#let icon(name: "") = {
  html.elem(
    "span",
    attrs: (class: "my-auto w-[24px]"),
    lucide-icon(name: name),
  )
}

#let parseDate(s) = {
  let (year, month, day, hour, minute, second) = s
    .match(regex("(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})"))
    .captures
    .map(int)
  datetime(
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    second: second,
  )
}

#html.elem("p", attrs: (class: "prose-xl lg:prose-2xl"))[
  #smallcaps(all: true)[Hi there. This is Youwen]. I study
  #link("https://en.wikipedia.org/wiki/Abstract_nonsense")[abstract nonsense]
  and hack on computers at #link("https://berkeley.edu")[UC Berkeley.] Welcome
  to my corner of the World Wide Web.
]

// #webimg(
//   "/static/img/sunset.jpg",
//   "ucsb campus point sunset",
//   extraImgClass: "max-h-[200px] w-full object-cover h-[200px]",
// )

#html.elem(
  "div",
  attrs: (
    class: "bg-gradient-to-tr from-love to-foam w-full rounded-md h-40 bg-[length:200%_auto] animate-gradient-move relative",
  ),
  html.elem(
    "span",
    attrs: (
      class: "absolute right-0 bottom-0 pb-2 pr-4 sm:text-2xl text-bg",
    ),
    [_Sunrise, parabellum._],
  ),
)

#let posts = json(bytes(sys.inputs.posts))

Previously, I was at #link("https://www.ucsb.edu/")[UC Santa Barbara.]
I also spent a semester in the CS department at
#link("https://www.tsinghua.edu.cn/en")[Tsinghua University.]

I help run #link("https://functor.systems")[functor.systems], a small computing
community, and tinker with #link("https://www.mit.edu/~ajzd/opencompute/")[MIT
  OpenCompute.]

Here is my #link("https://github.com/youwen5")[GitHub],
#link("/transcript")[university transcript], #link("/cv")[CV/resume], and
#link("/static/img/cat_babies.jpg")[a picture of my cats.]

In general, I prefer to use
#link("https://www.gnu.org/philosophy/free-sw.html")[free-as-in-freedom
  software.] I developed
#link("https://code.functor.systems/functor.systems/functorOS")[functorOS], an
experimental NixOS-based Linux distribution---among other free software
contributions.

I like #link("https://stallman.org/articles/on-hacking.html")[hacking], and
hackathons. I helped organize the 2026 #link("https://sbhacks.com/")[SB
  Hacks], the headliner hackathon of UC Santa Barbara, and was briefly its Director
of Development.

See #link("/about")[about] for more about myself, or #link("/now")[now] for
what I'm up to right now. Or #link("/explore")[explore] the other pages on this website.

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

// #blockquote(attribution: [--- #link(
//     "https://direct.mit.edu/books/oa-monograph/5460/Sheaf-Theory-through-Examples",
//   )[Rosiak, _Sheaf Theory through Examples_]])[
//   I happen to believe that many of the staple questions that were originally
//   the provenance of the philosopher will eventually be handled with the care
//   they deserve once they are adequately framed as problems within category
//   theory, and that in the near future every major philosophical
//   dialectic---universal--particular, continuous--discrete, global-local,
//   quality--quantity---and even less obvious problems, such as those of
//   "personal identity," will be handed over to, and considerably enriched by,
//   the category theorist.
// ]

#blockquote(attribution: [--- #link(
    "https://en.wikipedia.org/wiki/Alexander_Grothendieck",
  )[#smallcaps[Alexander Grothendieck]]])[
  Discovery is a child's privilege. I mean the small child, the child who is
  not afraid to be wrong, to look silly, to not be serious, and to act
  differently from everyone else. He is also not afraid that the things he is
  interested in are in bad taste or turn out to be different from his
  expectations, from what they should be, or rather he is not afraid of what
  they actually are. He ignores the silent and flawless consensus that is part
  of the air we breathe---the consensus of all the people who are, or are
  reputed to be, reasonable.
]

// #blockquote(
//   attribution: [--- #smallcaps[Volition], _Disco Elysium_],
// )[
//   No. This is somewhere to be. This is all you have, but it’s still something. Streets and sodium lights. The sky, the world. You’re still alive.
// ]

// #blockquote(attribution: [--- #link("")[The Zhuangzi]])[
//   Rewards and punishment is the lowest form of education.
//
//   (The Zhuangzi lamenting the current regime of reinforcement learning in
//   machine learning research.)
// ]

// #btw[
//   I recently embarked on a full redesign of the underlying infrastructure of
//   this website, switching from Rust to Haskell. The website mostly looks the
//   same, with a few upgraded features thanks to
//   #link("https://jaspervdj.be/hakyll/")[Hakyll], but there may be broken
//   hyperlinks or outdated content for a while. Pardon the dust!
// ]

// #html.elem(
//   "div",
//   attrs: (
//     class: "w-full h-40 relative mb-16",
//   ),
//   {
//     html.elem(
//       "div",
//       attrs: (
//         class: "absolute left-1/3 top-1/4 -translate-y-1/4 -translate-x-1/3 h-5/8 w-1/3 px-4 py-4 rounded-md bg-gradient-to-bl from-love to-foam",
//       ),
//       "",
//     )
//
//     html.elem(
//       "div",
//       attrs: (
//         class: "absolute left-1/3 top-1/4 translate-y-1/4 translate-x-1/3 h-5/8 w-1/3 px-4 py-4 rounded-md bg-gradient-to-tl from-iris to-pine",
//       ),
//       "",
//     )
//
//     html.elem("span", attrs: (
//       class: "absolute left-1/2 top-1/2 -translate-1/2 text-center w-full text-2xl text-zinc-100 dark:text-slate-100 mix-blend-difference",
//     ))[_Imagine_ what we can _become_.]
//   },
// )
//
// #blockquote(attribution: [--- Albert Einstein])[
//   Do not worry too much about your difficulty in mathematics, I can assure you that mine are still greater.
// ]

#show heading.where(level: 1): it => {
  html.elem("h2", attrs: (class: "!text-foreground"), it.body)
}

= Recently

#html.elem("p", attrs: (
  class: "text-sm text-subtle not-prose",
))[#link("/feed.xml")[RSS] and #link("/atom.xml")[Atom] feeds.]

#let update(date: "", is-link: true, internal: true, href: "", body) = {
  html.elem(
    if is-link { "a" } else { "span" },
    attrs: (
      href: href,
      class: "py-1 px-1 hover:bg-foreground hover:text-bg w-full w-full font-serif flex justify-between flex-wrap-reverse content-center gap-x-2 gap-y-1 md:gap-4",
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

#html.elem(
  "div",
  attrs: (class: "mt-2 divide-foreground divide-dashed divide-y"),
  {
    for post in posts.slice(0, count: 4) {
      update(date: post.date, href: post.url, {
        icon(name: "newspaper")
        post.title
      })
    }
    update(href: "/archive", date: icon(name: "move-right"), {
      icon(name: "folder-closed")
      [Archive (all posts)]
    })
  },
)

= Photos

#html.elem("p", attrs: (
  class: "text-sm text-subtle",
))[#link("/photos/feed.xml")[Atom] feed.]

#let photo-urls = (
  json("photos/manifest.json")
    .photos
    .slice(0, 10)
    .map(x => (
      web-url: x.webUrl,
      fullres: x.originalUrl,
      date: parseDate(x.exif.at("capturedAt", default: x.uploadedAt)).display(
        "[day padding:zero] [month repr:short], [year]",
      ),
      caption: if x.at("description", default: none) != none {
        x.description
      } else { none },
      alt: x.altText,
      location: {
        let city = x.location.at("city", default: none)
        let country = x.location.at("country", default: none)

        if (city == none) and (country == none) { none } else if (
          city == none
        ) { "Somewhere, " + country } else if (
          country == none
        ) { city + ", Earth" } else { city + ", " + country }
      },
      camera: (make: x.exif.cameraMake, model: x.exif.cameraModel),
      focal-length: x.exif.focalLength35mmEquivalent,
      f-number: x.exif.fNumber,
      shutter: str(100 / x.exif.exposureTimeSeconds),
      iso: x.exif.iso,
      mp: x.megapixels,
    ))
)

#let photo(data) = {
  let base-class = "p-1 hover:bg-foreground hover:text-bg space-y-1 group/child block shrink-0"
  // let final-class = if not show-in-selected {
  //   base-class + " group-[.show-selected]:hidden"
  // } else { base-class }
  let final-class = base-class

  html.elem(
    "a",
    attrs: (
      href: "/photos/viewer?data="
        + encodePhotoData({
          let exportData = data
          let _ = exportData.remove("web-url")

          exportData
        })
        + "#display",
      target: "_blank",
      class: final-class,
    ),
    {
      html.elem("img", attrs: (
        src: data.web-url,
        alt: data.alt,
        loading: "lazy",
      ))
      html.elem(
        "div",
        attrs: (
          class: "text-sm md:text-base px-1 w-0 min-w-full whitespace-normal break-words",
        ),
        [
          #html.elem(
            "span",
            attrs: (
              class: "text-sm text-subtle group-hover/child:text-bg leading-none",
            ),
            [
              #data.date
              #if data.location != none [
                @ #data.location
              ]
              #html.span(class: "hidden md:inline", [
                ·
                #(data.focal-length)mm
                ·
                f/#(data.f-number)
                ·
                1⁄#data.shutter
                ·
                #let cameraModel = if data.camera.model == "ILCE-7CM2" [
                  #(sym.alpha)7Cii
                ] else { data.camera.model }
                #data.camera.make #cameraModel
              ])
            ],
          )
          #if data.caption != none [
            \
            #html.span(class: "hidden lg:inline-block")[
              #data.caption
            ]
          ]
        ],
      )
    },
  )
}


#html.elem(
  "div",
  attrs: (
    class: "layout-horiz gap-8 mt-4 group show-selected not-prose photos-img-thumb-frontpage mx-auto min-w-full w-0",
  ),
  {
    for elem in (
      photo-urls.map(it => photo(it))
    ) {
      elem
    }
  },
)

#html.elem(
  "a",
  attrs: (
    href: "/photos/gallery",
    class: "p-1 font-serif hover:text-bg hover:bg-foreground border-b-1 border-b-foreground text-foreground decoration-none min-w-full inline-flex justify-between content-center min-h-[50px]",
  ),
  {
    html.elem("span", attrs: (class: "flex gap-1 my-auto"))[
      #icon(name: "camera")
      Full gallery
    ]
    icon(name: "move-right")
  },
)

#heading[
  Notes
  #html.a(
    href: "/notes",
    class: "text-link inline-flex gap-0.5",
  )[(See more)]
]

#html.div(
  class: "!mt-4 py-2 px-4 text-[0.75em] rounded-md border-1 border-slate-200 dark:border-zinc-700 bg-slate-50 dark:bg-overlay leading-[1.5em] w-fit max-w-[60ch]",
  [Under construction.],
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
      B.A. Mathematics, Computer Science \
      University of California, Berkeley ('28)
    ]
    #double-entry[
      Visiting student, CS department \
      Tsinghua University (S26)
    ]
    #double-entry[
      B.S. Mathematics, Computer Science \
      University of California, Santa Barbara (cut short)
    ]
  ]
  #html.elem("div", attrs: (class: "space-y-[7.33px] prose-lg"))[
    #location-entry(area: [in Berkeley], country-or-state: [
      #smallcaps(all: true)[California, USA]
    ])
    #location-entry(area: [near San Francisco], country-or-state: [
      #smallcaps(all: true)[California, USA]
    ])
    #location-entry(area: [previously in Beijing], country-or-state: [
      #smallcaps(all: true)[China]
    ])
    #location-entry(area: [previously in Santa Barbara], country-or-state: [
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
    class: "bg-gradient-to-r from-love to-foam w-full rounded-md mt-8 h-24 relative",
  ),
  html.elem(
    "span",
    attrs: (
      class: "absolute right-0 bottom-0 pb-2 pr-4 sm:text-2xl text-bg",
    ),
    [_Imagine what we can become._],
  ),
)
