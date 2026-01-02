#let pesha(
  name: "",
  address: "",
  contacts: (),
  profile-picture: none,
  paper-size: "us-letter",
  footer-text: none,
  page-numbering-format: "1 of 1",
  body,
) = {
  // Set document metadata.
  set document(title: name, author: name, keywords: (
    name,
    "curriculum vitae",
    "cv",
    "resume",
  ))

  // Configure text properties.
  set text(size: 10pt, hyphenate: false, font: "Valkyrie OT B")

  // Set page properties.
  set page(
    paper: paper-size,
    margin: (
      x: 14%,
      top: if profile-picture == none { 13% } else { 8.6% },
      bottom: 10%,
    ),
    // Display page number in footer only if there is more than one page.
    footer: context {
      set align(center)
      show text: it => { text(size: 0.85em, it) }
      let total = counter(page).final().first()
      if total > 1 {
        let i = counter(page).at(here()).first()
        smallcaps(all: true)[#footer-text #h(2pt) #sym.circle.filled.small #h(
            2pt,
          ) #counter(page).display(page-numbering-format, both: true)]
      } else {
        smallcaps(all: true)[#footer-text]
      }
    },
  )

  // Display title and contact info.
  block(width: 100%, below: 1.5em)[
    #let header-info = {
      smallcaps(all: true, text(size: 1.8em, name))
      v(1.4em, weak: true)
      show text: it => { text(size: 1em, it) }
      address
      if contacts.len() > 0 {
        v(1em, weak: true)
        grid(columns: contacts.len(), gutter: 1em, ..contacts)
      }
    }
    #if profile-picture != none {
      grid(
        columns: (1fr, auto),
        box(
          clip: true,
          width: 3.3cm,
          height: 3.3cm,
          radius: 2.5cm,
          profile-picture,
        ),
        align(right + horizon, header-info),
      )
    } else {
      align(center, header-info)
    }
  ]

  // Configure heading properties.
  show heading: it => {
    line(length: 100%, stroke: 0.5pt)
    pad(top: -0.85em, left: 0.25em, bottom: 0.6em, text(size: 0.7em, smallcaps(
      all: true,
      it,
    )))
  }

  // Configure paragraph properties.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")

  body
}

// This function formats its `body` (content) into a block of experience section.
#let experience(
  body,
  place: none,
  title: none,
  location: none,
  time: none,
) = {
  set list(body-indent: 0.85em)

  block(width: 100%, pad(left: 0.25em)[
    #text(size: 1em, [#if place != none { place } else { title }]) #h(
      1fr,
    ) #text(size: 1em, time)
    #v(1em, weak: true)
    #if place != none {
      emph(text(title))
    }
    #if location != none [
      #h(1fr) #text(size: 1em, location)
    ]
    #v(1em, weak: true)
    #body
  ])
}
