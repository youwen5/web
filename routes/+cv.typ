#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(
  title: "Curriculum Vitae",
  date: datetime(day: 11, month: 5, year: 2025),
  meta-description: "Youwen Wu's resume / curriculum vitae.",
)

This page is kind of broken right now, please mind the jank.

#let cv-line(..args) = {
  args.pos().at(0)
  args.pos().at(1)
}
#let double-entry(body) = {
  html.elem(
    "div",
    attrs: (
      class: "border-b-love border-b-1 flex flex-wrap justify-between py-1",
    ),
    body,
  )
}

#let single-entry(body) = {
  html.elem("div", attrs: (class: "border-b-love border-b-1"), body)
}


= Education

#html.elem("div", attrs: (
  class: "font-sans font-light text-love",
))[
  #html.elem("div", attrs: (class: "space-y-2 prose-lg"))[
    #double-entry[
      #html.elem("span")[
        B.S. Mathematics --- University of California, Santa Barbara
      ]
      #html.elem("span")[
        GPA: 3.97/4.0
      ]
    ]
    #double-entry[
      #html.elem("span")[
        B.S. Computer Science --- University of California, Santa Barbara
      ]
      #html.elem("span")[
        Minor in Philosophy
      ]
    ]
  ]
]

#let cv-entry(date: "", employer: "", title: "", ..args) = [
  #title

  #employer

  #date

  #if args.pos().len() > 0 {
    args.pos().at(0)
  }
]

= Experience

#cv-entry(
  date: [11/2024 -- Present],
  employer: [UCSB Robotics Lab],
  title: [Systems programmer],
  [#text(10pt, [
      Designed reproducible and purely functional hermetic build systems.
      Creating 3D simulacrums of laboratory experiments that are reproduced in
      real life, using C++, React, and Three.js.
    ])],
)

#cv-entry(
  date: [11/2024 -- Present],
  employer: [NixOS Foundation],
  title: [Package maintainer],
  [#text(10pt, [
      Maintaining packages for NixOS, an purely functional GNU/Linux
      distribution built on the Nix package manager and Nix programming
      language.
    ])],
)

#cv-entry(
  date: [09/2022 -- 06/2024],
  employer: [FIRST Robotics Team 1280],
  title: [Artificial intelligence lead],
  [#text(
      10pt,
      [
        Worked on autonomous decision making and path planning algorithms.
        Replaced the venerable _BozoAuto_ autonomous subroutine with the
        _DeepBozo_ autonomous suite. Designed a novel robot control dashboard
        with 3D visualization using Rust, Tauri, and Svelte. Won 2022 Monterey Bay Regional Competition.
      ],
    )],
)

= Skills

#cv-line[
  Languages
][
  Rust, Haskell, C++, TypeScript, Python, Nix.
]

#cv-line[
  Web
][
  React, SvelteKit, Tauri, Next.js, Elm.
]

= Awards

#let award = (name, description) => {
  cv-line([2/2024], [
    *#name*

    #text(size: 0.85em, description)
  ])
}

#award[National Merit Semifinalist][
  Issued by #link("https://www.nationalmerit.org/s/1758/start.aspx?gid=2&pgid=61")[National Merit Scholarship Corporation].
]
