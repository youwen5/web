#import "@luminite/html-shim:0.1.0": *

#show: html-shim

#smallcaps(all: true)[Greetings. I#(apostrophe)m Youwen]. I study math and hack on computers at
#link("https://ucsb.edu")[UC Santa Barbara].

#webimg(
  "/static/img/sunset.jpg",
  "ucsb campus point sunset",
  extraClass: "max-h-[200px] w-full object-cover h-[200px]",
)

#html.elem("div", attrs: (class: "prose-lg lg:prose-xl"))[
  Here is my #link("https://github.com/youwen5")[GitHub], #link("/transcript")[university transcript], #link("https://www.last.fm/user/couscousdude")[last.fm], and #link("/static/img/cat_babies.jpg")[a picture of my cats].

  I am interested in the #link("https://ncatlab.org/nlab/show/nPOV")[#emph[n]POV] and
  how we can apply higher structures to solve hard problems. In general, I prefer
  to use #link("https://www.gnu.org/philosophy/free-sw.html")[free-as-in-freedom
    software]. I think we should
  #link("https://vlad.website/the-philosophy-of-the-open-source-pledge/")[pay
    open source developers].

  In my spare time, I play guitar and spend too much money on guitar pedals. I
  also hate coding.

  See my #link("/now")[now page] for what I#(apostrophe)m up to right now.

  #blockquote(
    attribution: [--- #link("https://www.paulgraham.com/top.html")[Paul Graham]],
  )[It's hard to do a really good job on anything you don't think about in the shower.]

  = Contact

  #html.elem(
    "div",
    attrs: (class: "font-sans w-full prose-lg"),
    {
      let icon(name: "") = {
        html.elem(
          "span",
          attrs: (class: "my-auto"),
          lucide-icon(name: name),
        )
      }
      let entry(href: "/impressum", is-link: true, newtab: true, body) = {
        html.elem(
          "div",
          html.elem(
            if is-link { "a" } else { "div" },
            attrs: (
              href: href,
              target: if newtab { "_blank" } else { "" },
              class: "px-1 py-1 font-light hover:text-base hover:bg-love border-b-1 border-b-love text-love decoration-none min-w-full inline-flex justify-between content-center min-h-[50px]",
            ),
            {
              html.elem(
                "span",
                attrs: (class: "flex gap-2 my-auto"),
                body,
              )
              if is-link {
                icon(name: "square-arrow-out-up-right")
              }
            },
          ),
        )
      }
      entry(href: "/impressum", newtab: false)[
        #icon(name: "send")
        Send me electronic mail
      ]
      entry(href: "https://github.com/youwen5")[
        #icon(name: "github")
        See my code on GitHub
      ]
      entry(href: "https://www.instagram.com/youwenw5/")[
        #icon(name: "instagram")
        Instagram
      ]
      entry(href: "https://www.linkedin.com/in/youwen-wu-306221288/")[
        #icon(name: "linkedin")
        LinkedIn
      ]
      entry(is-link: false)[
        #icon(name: "brain")
        Telepathically scribe me over the ethereal plane
      ]
    },
  )

  = Places

  #html.elem(
    "div",
    attrs: (
      class: "grid grid-cols-1 md:grid-cols-2 gap-6 font-sans font-light text-love",
    ),
  )[
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
        area: [previously in Salt Lake City],
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
  ]
]
