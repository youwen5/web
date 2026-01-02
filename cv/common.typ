#import "@preview/html-shim:0.1.0": *
#import "./pesha.typ": *

#let render-cv(long: false) = [
  I'm passionate about _design_---in all its facets---including systems, web, graphics, typography, and more. I love working on hard problems.

  #context {
    if target() == "html" {
      html.elem(
        "div",
        attrs: (class: "space-x-6"),
        {
          html.elem(
            "a",
            attrs: (
              class: "inline-flex gap-2 font-sans hover:text-pine hover:dark:text-foam",
              href: if long { "/cv/youwen-wu-cv-full.pdf" } else {
                "/cv/youwen-wu-cv-short.pdf"
              },
              target: "_blank",
            ),
            {
              lucide-icon(class: "my-auto", name: "file-text")
              html.elem("span")[View as PDF]
            },
          )
          html.elem(
            "a",
            attrs: (
              class: "inline-flex gap-2 font-sans hover:text-pine hover:dark:text-foam",
              href: "/#contact",
            ),
            {
              lucide-icon(class: "my-auto", name: "mail")
              html.elem("span")[Contact]
            },
          )
        },
      )
      let selected-class = "before:content-['●'] before:text-[0.55em] before:text-foam before:pr-2 my-auto inline-flex before:my-auto"
      let unselected-class = "before:content-['○'] before:text-[0.55em] before:pr-2 inline-flex my-auto before:my-auto hover:before:content-['●']"
      html.elem(
        "div",
        attrs: (
          class: "px-3 py-1 text-base rounded-md border-1 border-zinc-300 dark:border-zinc-700 text-subtle font-sans flex flex-wrap gap-x-6 w-fit mt-5",
        ),
        {
          html.elem(
            "a",
            attrs: (
              href: "/cv",
              class: if long { selected-class } else { unselected-class },
            ),
            [Full],
          )
          html.elem(
            "a",
            attrs: (
              href: "/cv/short",
              class: if not long { selected-class } else { unselected-class },
            ),
            [Short],
          )
        },
      )
    }
  }

  = Education

  #let education-section(body) = context {
    if target() == "html" {
      html.elem(
        "div",
        attrs: (
          class: "font-sans font-light space-y-2 prose-lg",
        ),
        body,
      )
    } else {
      body
    }
  }

  #let education-entry(institution: [], degree: [], date: []) = context {
    if target() == "html" {
      html.elem(
        "div",
        attrs: (
          class: "border-b-foreground border-b-1 flex flex-wrap justify-between py-1",
        ),
      )[
        #html.elem("span", attrs: (class: "font-normal"))[
          #institution \
          #html.elem(
            "span",
            attrs: (
              class: "font-serif",
            ),
            degree,
          )
        ]
        #html.elem("span", date)
      ]
    } else {
      experience(place: institution, time: date)[
        - #degree
      ]
    }
  }

  #education-section[
    #education-entry(
      institution: [University of California, Santa Barbara],
      degree: [B.S. _in_ Mathematics (GPA: 3.96)],
      date: [2024 --- 2028 (expected)],
    )
    #education-entry(
      institution: [University of California, Santa Barbara],
      degree: [B.S. _in_ Computer Science],
      date: [2024 --- 2028 (expected)],
    )
    #if long {
      education-entry(
        institution: [Tsinghua University, Beijing],
        degree: [Visiting exchange student],
        date: [2026 (anticipated)],
      )
    }
  ]

  #let entry-wrapper(body) = context {
    if target() == "html" {
      html.elem(
        "div",
        attrs: (
          class: "md:grid grid-cols-4 gap-x-8 gap-y-2 w-full font-sans font-light",
        ),
        body,
      )
    } else {
      body
    }
  }

  #let base-html-entry(left: [], heading: [], ..args) = {
    html.elem("div", attrs: (class: "col-span-1"), left)
    html.elem("div", attrs: (class: "col-span-3 mt-[3px]"), [
      #html.elem(
        "div",
        attrs: (class: "font-normal text-lg md:text-xl"),
        heading,
      )
      #if args.pos().len() > 0 {
        html.elem("div", attrs: (
          class: "-mt-4 font-serif font-normal text-base md:text-lg",
        ))[
          #args.pos().at(0)
        ]
      }
    ])
  }

  #let experience-entry(
    date: "",
    location: "",
    employer: "",
    title: "",
    web-only: false,
    body,
  ) = context {
    if target() == "html" {
      base-html-entry(
        left: [
          #date
          #if location != "" {
            linebreak()
            html.elem("span", attrs: (class: "text-base xl:text-lg"), location)
          }
        ],
        heading: [
          #title #html.elem("span", attrs: (class: "font-light"))[at] #employer
        ],
        body,
      )
    } else if (not web-only) {
      experience(
        title: title,
        place: employer,
        time: date,
        location: location,
        body,
      )
    }
  }


  = Experience

  #entry-wrapper[
    #experience-entry(
      date: [03/25 --- now],
      location: [Earth],
      employer: [MIT OpenCompute Lab],
      title: [Hacker],
      [#text(
        10pt,
        [
          - Organizing/participating in reading groups, hardware/software projects
        ],
      )],
    )
    #experience-entry(
      date: [11/24 --- 06/25],
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

    #if long [
      #experience-entry(
        date: [11/24 --- now],
        location: [Earth],
        employer: [NixOS],
        title: [Open source maintainer],
        [#text(10pt, [
          - Maintaining nixpkgs & NixOS, a purely functional GNU/Linux
            distribution built on the Nix package manager and Nix programming
            language
        ])],
      )
    ]

    #if long [
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
    ]
  ]

  = Projects

  #let project-entry(
    date: [],
    project: [],
    link: "",
    type: "",
    demo-link: "",
    web-only: false,
    body,
  ) = context {
    if target() == "html" {
      base-html-entry(
        left: [
          #date \
          #if type == "github" {
            html.elem(
              "a",
              attrs: (
                class: "mt-2 hover:text-pine hover:dark:text-foam hidden md:inline-flex gap-2 mr-2 text-nowrap text-lg",
                href: link,
                target: "_blank",
              ),
              {
                html.elem(
                  "span",
                  attrs: (class: "my-auto w-[24px]"),
                  lucide-icon(name: "github"),
                )
                [View code]
              },
            )
          }
          #if demo-link != "" {
            html.elem(
              "a",
              attrs: (
                class: "mt-1 hover:text-pine hover:dark:text-foam hidden md:inline-flex gap-2 text-nowrap text-lg",
                href: demo-link,
                target: "_blank",
              ),
              {
                html.elem(
                  "span",
                  attrs: (class: "my-auto w-[24px]"),
                  lucide-icon(name: "box"),
                )
                [Try demo]
              },
            )
          }
        ],
        heading: project,
        [
          #body
          #html.elem(
            "div",
            attrs: (class: "-mt-2 mb-4"),
            {
              if type == "github" {
                html.elem(
                  "a",
                  attrs: (
                    class: "hover:text-pine hover:dark:text-foam md:hidden inline-flex gap-2 mr-4 font-sans",
                    href: link,
                    target: "_blank",
                  ),
                  {
                    html.elem(
                      "span",
                      attrs: (class: "my-auto"),
                      lucide-icon(
                        name: "github",
                      ),
                    )
                    [View code]
                  },
                )
              }
              if demo-link != "" {
                html.elem(
                  "a",
                  attrs: (
                    class: "hover:text-pine hover:dark:text-foam md:hidden inline-flex gap-2 font-sans",
                    href: demo-link,
                    target: "_blank",
                  ),
                  {
                    html.elem(
                      "span",
                      attrs: (class: "my-auto"),
                      lucide-icon(
                        name: "box",
                      ),
                    )
                    [Try demo]
                  },
                )
              }
            },
          )
        ],
      )
    } else if (not web-only) {
      experience(title: project, time: date, body)
    }
  }

  #entry-wrapper[
    #project-entry(
      date: [2025],
      project: [Colmena Maps],
      link: "https://code.functor.systems/youwen/colmena-maps",
      type: "github",
    )[
      - Embodied agentic AI system that hunts down any desired item in Google Streetview using novel geospatial intelligence and spacetime-embeddings
      - Won HackMIT 2025 Grand Prize (worth over US\$4,000)
    ]
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

    #context {
      if long [
        #project-entry(
          date: [2025],
          project: [
            web.youwen.dev
            #if target() == "html" [(this website)]
          ],
          link: "https://github.com/youwen5/web",
          demo-link: if target() == "html" { "" } else {
            "https://web.youwen.dev"
          },
          type: "github",
        )[
          - Powered by a fully custom handrolled static site generator, written in Rust
          #if target() == "html" [
            - Accessible, perfect 100s on Google's Lighthouse benchmark
          ] else [
            - My personal website
          ]
        ]
      ]
    }

    #if long [
      #project-entry(
        date: [2024],
        project: [functorOS],
        link: "https://code.functor.systems/functor.systems/functorOS",
        type: "github",
      )[
        - A highly experimental NixOS based Linux® distribution
      ]
    ]

    #if long [
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
    ]

    #if long [
      #project-entry(
        date: [2024],
        project: [eeXiv],
        link: "https://github.com/youwen5/eexiv",
        type: "github",
        demo-link: "https://eexiv.solipsism.social/",
      )[
        - An arXiv clone for archiving research documents written by Team 1280, a FIRST Robotics team
      ]
    ]
  ]

  = Awards and honors

  #entry-wrapper[
    #let award-entry(title: [], date: [], web-only: false, ..args) = context {
      if target() == "html" {
        if args.pos().len() > 0 {
          base-html-entry(left: date, heading: title, args.pos().at(0))
        } else {
          base-html-entry(left: date, heading: title)
        }
      } else if (not web-only) {
        experience(place: title, time: date)[]
      }
    }

    #if long [
      #award-entry(
        title: [George H. Griffiths and Olive J. Griffiths Scholarship (UCSB)],
        date: [2025],
      )
    ]
    #award-entry(title: [HackMIT 2025 Grand Prize], date: [2025])
    #if long [
      #award-entry(
        title: [Dean's Honors #(sym.times)3],
        date: [2024 --- 2025],
        web-only: true,
      )
    ]
    #award-entry(title: [National Merit Semifinalist], date: [2024])
  ]
]
