#let html-shim(
  body,
  date: none,
  special-author: none,
  location: none,
  title: none,
) = {
  show math.equation.where(block: false): it => {
    set text(size: 1.5em)
    html.elem(
      "span",
      attrs: (role: "math", class: "math inline-math"),
      html.frame(it),
    )
  }

  show math.equation.where(block: true): it => {
    set text(size: 1.5em)
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

  body

  [
    #metadata(date) <date>
    #metadata(special-author)<special-author>
    #metadata(location)<location>
    #metadata(title) <title>
  ]
}

#let blockquote = (attribution: none, body) => {
  html.elem(
    "blockquote",
    attrs: (class: "border-l-solid border-l-4 border-l-iris px-4"),
    {
      body
      if attribution != none {
        html.elem("div", attrs: (class: "w-full text-end"), [--- #attribution])
      }
    },
  )
}

#let dinkus = {
  html.elem("hr")
  html.elem(
    "div",
    attrs: (class: "w-full text-center text-xl text-subtle"),
    [⁂],
  )
}
