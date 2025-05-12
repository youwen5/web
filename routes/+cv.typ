#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(
  title: "Curriculum Vitae",
  date: datetime(day: 11, month: 5, year: 2025),
  meta-description: "Youwen Wu's resume / curriculum vitae.",
)

#let cv-line(..args) = {
  args.pos().at(0)
  if (args.pos().len() > 1) {
    args.pos().at(1)
  }
}
#let double-entry(body) = {
  html.elem(
    "div",
    attrs: (
      class: "border-b-foreground border-b-1 flex flex-wrap justify-between py-1",
    ),
    body,
  )
}

#let single-entry(body) = {
  html.elem("div", attrs: (class: "border-b-love border-b-1"), body)
}

I#(apostrophe)m passionate about _design_---in all its facets---including systems, web, graphics, typography, and more. I love working on hard problems.

= Education

#html.elem("div", attrs: (
  class: "font-sans font-light",
))[
  #html.elem("div", attrs: (class: "space-y-2 prose-lg"))[
    #double-entry[
      #html.elem("span", attrs: (class: "font-normal"))[
        University of California, Santa Barbara \
        #html.elem("span", attrs: (
          class: "font-serif",
        ))[B.S. _in_ Mathematics]
      ]
      #html.elem("span")[
        2024 --- 2028 (expected)
      ]
    ]
    #double-entry[
      #html.elem("span", attrs: (class: "font-normal"))[
        University of California, Santa Barbara \
        #html.elem("span", attrs: (
          class: "font-serif",
        ))[B.S. _in_ Computer Science]
      ]
      #html.elem("span")[
        2024 --- 2028 (expected)
      ]
    ]
  ]
]

#let base-entry(left: [], heading: [], ..args) = [
  #html.elem(
    "div",
    attrs: (
      class: "md:grid grid-cols-4 gap-8 w-full font-sans my-6 md:my-1 font-light",
    ),
    [
      #html.elem("div", attrs: (class: "col-span-1"), left)
      #html.elem("div", attrs: (class: "col-span-3"), [
        #html.elem("div", attrs: (class: "font-normal"), heading)
        #if args.pos().len() > 0 {
          html.elem("div", attrs: (class: "-mt-4"))[
            #args.pos().at(0)
          ]
        }
      ])
    ],
  )
]

#let experience-entry(
  date: "",
  location: "",
  employer: "",
  title: "",
  body,
) = base-entry(
  left: [
    #date
    #if location != "" {
      linebreak()
      html.elem("span", attrs: (class: "text-sm xl:text-lg"), location)
    }
  ],
  heading: [
    #title #html.elem("span", attrs: (class: "font-light"))[at] #employer
  ],
  body,
)


= Experience

#experience-entry(
  date: [11/24 --- now],
  location: [Santa Barbara, CA],
  employer: [UCSB Robotics Lab],
  title: [Systems programmer],
  [#text(
      10pt,
      [
        - Designed reproducible build systems massively speeding up development iteration
        - Creating 3D simulacrums of laboratory experiments that are reproduced in
          real life, using C++, React, and Three.js
      ],
    )],
)

#experience-entry(
  date: [11/24 --- now],
  location: [Earth],
  employer: [NixOS],
  title: [Package maintainer],
  [#text(10pt, [
      - Maintaining packages for NixOS, an purely functional GNU/Linux
        distribution built on the Nix package manager and Nix programming
        language
    ])],
)

#experience-entry(
  date: [09/22 --- 06/24],
  location: [SF Bay Area, CA],
  employer: [FIRST Robotics Team 1280],
  title: [Artificial intelligence lead],
  [#text(10pt, [
      - Worked on autonomous decision making and path planning algorithms
      - Replaced the venerable *BozoAuto* autonomous subroutine with the
        *DeepBozo* autonomous suite
      - Designed a novel robot control dashboard
        with 3D visualization using Rust, Tauri, and Svelte
      - Won 2022 Monterey Bay Regional Competition
    ])],
)

= Projects

#let project-entry(
  date: [],
  project: [],
  link: "",
  type: "",
  demo-link: "",
  body,
) = base-entry(
  left: [
    #date \
    #if type == "github" {
      html.elem(
        "a",
        attrs: (
          class: "mt-3 hover:text-rose hidden md:inline-flex gap-2 mr-2 text-nowrap",
          href: link,
          target: "_blank",
        ),
      )[
        #html.elem("span", attrs: (class: "my-auto"), lucide-icon(
          name: "github",
        ))
        View code
      ]
    }
    #if demo-link != "" {
      html.elem("a", attrs: (
        class: "mt-1 hover:text-rose hidden md:inline-flex gap-2 text-nowrap",
        href: demo-link,
        target: "_blank",
      ))[
        #html.elem("span", attrs: (class: "my-auto"), lucide-icon(name: "box"))
        Try demo
      ]
    }
  ],
  heading: project,
  [
    #body
    #if type == "github" {
      html.elem("a", attrs: (
        class: "-mt-2 hover:text-rose md:hidden inline-flex gap-2 mr-2",
        href: link,
        target: "_blank",
      ))[
        #html.elem("span", attrs: (class: "my-auto"), lucide-icon(
          name: "github",
        ))
        View code
      ]
    }
    #if demo-link != "" {
      html.elem("a", attrs: (
        class: "mt-1 hover:text-rose md:hidden inline-flex gap-2",
        href: demo-link,
        target: "_blank",
      ))[
        #html.elem("span", attrs: (class: "my-auto"), lucide-icon(name: "box"))
        Try demo
      ]
    }
  ],
)

#project-entry(
  date: [2025],
  project: [Virion],
  link: "https://github.com/youwen5/virion",
  type: "github",
  demo-link: "https://virion.youwen.dev",
)[
  - Compartmental epidemic modeler and 3D pandemic visualizer for the H5N1 avian influenza in the United States
  - Won award at the #link("https://dataorbit-2025.devpost.com/")[UCSB DataOrbit Hackathon]
]

#project-entry(
  date: [2025],
  project: [This website],
  link: "https://github.com/youwen5/web",
  type: "github",
)[
  - Powered by a fully custom handrolled static site generator, written in Rust
  - Accessible, perfect 100s on Google's Lighthouse benchmark
]

#project-entry(
  date: [2024],
  project: [liminalOS],
  link: "https://github.com/youwen5/liminalOS",
  type: "github",
)[
  - My custom Linux distribution based on NixOS
]

#project-entry(
  date: [2024],
  project: [Jankboard],
  link: "https://github.com/youwen5/jankboard",
  type: "github",
)[
  - A bespoke driver control dashboard for Team 1280's 2024 competition robot
  - Tauri application, with Svelte frontend and Rust glue code to communicate with robot
  - 3D robot visualization using Three.js
]

#project-entry(
  date: [2024],
  project: [eeXiv],
  link: "https://github.com/youwen5/eexiv",
  type: "github",
  demo-link: "https://eexiv.solipsism.social/",
)[
  - An arXiv clone for archiving research documents written by Team 1280, a FIRST Robotics team
]

= Awards and honors

#let award-entry(title: [], date: [], ..args) = {
  if args.pos().len() > 0 {
    base-entry(left: date, heading: title, args.pos().at(0))
  } else {
    base-entry(left: date, heading: title)
  }
}

#let award = (name, description) => {
  cv-line([2/2024], [
    *#name*

    #text(size: 0.85em, description)
  ])
}

#award-entry(title: [UCSB DataOrbit, Winner], date: [2025])
#award-entry(title: [SB Hacks XI, Winner], date: [2025])
#award-entry(
  title: [Dean#(apostrophe)s Honors #(sym.times)2],
  date: [2024 --- 2025],
)
#award-entry(title: [National Merit Semifinalist], date: [2024])
