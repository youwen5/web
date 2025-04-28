#import "@luminite/html-shim:0.1.0": *
#import "@preview/cetz:0.3.4"

#show: html-shim.with(
  date: datetime(
    day: 22,
    year: 2025,
    month: 4,
  ).display("[day] [month repr:long] [year]"),
  title: "A test of Typst math rendering",
)

#show <render-svg>: it => {
  set text(size: 1.5em)
  html.elem(
    "figure",
    attrs: (role: "math", class: "block-math"),
    html.frame(it),
  )
}

Let $U$ and $V$ be $FF$-vector spaces. Suppose that $U$ is finite-dimensional of dimension $n >= 1$. Let $S = {u_1,...,u_n}$ be a basis for $U$. Given any map $f : S -> V$ (of sets), show that there is a unique linear map
$
  tau_f : U -> V
$
such that $tau_f (u_i) = f(u_i)$ for all $i = 1,...,n$.

Let $f : S -> V$ is a map. Let $tau_f$ be a linear map that satisfies $tau_f
(u_i) = f(u_i)$. Let $x$ be any vector in $U$. Because $S$ is a basis, $exists lambda_1,...,lambda_n$ s.t. $x = lambda_1 u_1 + dots.c + lambda_n u_n$. By linearity, $tau_f (x) = lambda_1 tau_f (u_1) + dots.c + lambda_n tau_f (u_n) = lambda_1 f(u_1) + dots.c + lambda_n f(u_n)$.

Suppose there was another linear map, $tau'_f$, where
$tau'_f (u_i) = f(u_i)$ for all $i = 1,...,n$. Because $S$ is a basis, the representation $x = lambda_1 u_1 + dots.c + lambda_n u_n$ is unique, so $tau'_f (x) = lambda_1 tau'_f (u_1) + dots.c + lambda_n tau'_f (u_n) = lambda_1 f(u_1) + dots.c + lambda_n f(u_n)$. So $forall x in U$, $tau_f (x) = tau'_f (x)$ and $tau_f = tau'_f$.

== And we can even render graphics

This is not an image. It is generated at compile time by CeTZ code (best results in light mode). Although text is not fully rendered properly, this is just a proof-of-concept.

#figure(
  cetz.canvas({
    import cetz.draw: *

    set-style(content: (frame: "rect", stroke: none, fill: white, padding: .1))

    grid((0, 0), (8, 6), help-lines: true)
    line(
      (1, -0.5),
      (5, -0.5),
      mark: (start: "o", end: (symbol: "o", fill: black)),
      name: "A",
    )
    content("A.mid", [$A$])
    line(
      (-0.5, 1),
      (-0.5, 4),
      mark: (start: (symbol: "o", fill: black), end: "o"),
      name: "B",
    )
    content("B.mid", [$B$])

    line(
      (4, -1),
      (7, -1),
      mark: (start: (symbol: "o", fill: black), end: "o"),
      name: "C",
    )
    content("C.mid", [$C$])
    line(
      (-1, 2),
      (-1, 5),
      mark: (start: "o", end: "o"),
      name: "D",
    )
    content("D.mid", [$D$])

    set-style(content: (frame: "rect", stroke: none, fill: none, padding: .1))

    line(
      (4, -1.5),
      (5, -1.5),
      mark: (
        start: (symbol: "o", fill: black),
        end: (symbol: "o", fill: black),
      ),
      name: "AnC",
    )
    content(
      ("AnC.start", 50%, "AnC.end"),
      angle: "AnC.end",
      padding: .2,
      anchor: "north",
      [$A inter C$],
    )

    line(
      (-1.5, 2),
      (-1.5, 4),
      mark: (start: "o", end: "o"),
      name: "BnD",
    )
    content(
      ("BnD.start", 50%, "BnD.end"),
      angle: "BnD.end",
      padding: .1,
      anchor: "south",
      [$B inter D$],
    )

    rect((1, 1), (5, 4), fill: red, name: "AxB")
    content("AxB", [$A times B$])
    rect((4, 2), (7, 5), fill: blue, name: "CxD")
    content("CxD", [$C times D$])
    rect((4, 2), (5, 4), fill: purple, name: "overlap")
    line((2, 6), (4.5, 3), stroke: (dash: "dashed"), name: "label")
    content(
      "label.start",
      padding: .1,
      anchor: "south",
      [$(A inter C) times (B inter D) = (A times B) inter (C times D)$],
    )
  }),
)<render-svg>
