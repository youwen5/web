#let html-shim(body) = {
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
}

