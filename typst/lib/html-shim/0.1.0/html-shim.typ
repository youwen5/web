#let html-shim(
  body,
  date: none,
  special-author: none,
  location: none,
  title: none,
  subtitle: none,
  meta-description: none,
  short-description: none,
) = {
  show math.equation.where(block: false): it => {
    set text(size: 1.3em)
    html.elem(
      "span",
      attrs: (role: "math", class: "math inline-math"),
      html.frame(it),
    )
  }

  show math.equation.where(block: true): it => {
    set text(size: 1.3em)
    html.elem(
      "figure",
      attrs: (role: "math", class: "math block-math inline-block"),
      html.frame(it),
    )
  }

  show smallcaps: it => {
    show text: it2 => html.elem(
      "span",
      attrs: (class: "smallcaps inline-block"),
      it2,
    )

    it
  }

  show raw.where(block: true): it => {
    if it.lang == none {
      return it
    }

    html.elem(
      "pre",
      html.elem(
        "code",
        attrs: (class: "language-" + it.lang),
        it.text,
      ),
    )
  }

  let date_exists = if date != none {
    date.display("[year]-[month]-[day]T00:00:00.00-08:00")
  }

  let page_metadata = (
    // ISO 3339
    date: date_exists,
    special-author: special-author,
    location: location,
    title: title,
    subtitle: subtitle,
    meta-description: meta-description,
    short-description: short-description,
  )

  [
    #metadata(page_metadata) <metadata>
  ]

  body
}

#let blockquote = (attribution: none, body) => {
  html.elem(
    "blockquote",
    attrs: (
      class: "border-l-solid border-l-4 border-l-subtle px-4 w-fit text-[0.85em]",
    ),
    {
      body
      if attribution != none {
        html.elem(
          "div",
          attrs: (class: "w-fit ml-auto text-subtle"),
          attribution,
        )
      }
    },
  )
}

#let dinkus = {
  html.elem("hr")
  html.elem(
    "div",
    attrs: (class: "w-full text-center text-xl text-subtle select-none"),
    [⁂],
  )
}

#let webimg = (src, alt, extraClass: none) => {
  let base-classes = "rounded-md mx-auto shadow-sm dark:shadow-none shadow-gray-900"
  let classes = if extraClass != none {
    base-classes + " " + extraClass
  } else {
    base-classes
  }
  html.elem("img", attrs: (src: src, alt: alt, class: classes))
}
