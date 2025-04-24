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
      attrs: (role: "math", class: "math block-math"),
      html.frame(it),
    )
  }
  body
}
