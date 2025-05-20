#import "@epilogue/html-shim:0.1.0": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#show: html-shim.with(
  date: datetime(day: 19, year: 2025, month: 5),
  location: "Santa Barbara, California",
  title: "Three isomorphism theorems in linear algebra",
  math-escape-mode: true,
)

#let proof(body, name: none) = {
  [_Proof_]
  if name != none {
    [ #thmname[#name]]
  }
  [.]
  body

  // Add a word-joiner so that the proof square and the last word before the
  // 1fr spacing are kept together.
  sym.wj

  // Add a non-breaking space to ensure a minimum amount of space between the
  // text and the proof square.
  sym.space.nobreak
  tombstone
}

#[
  When I first learned about these they were difficult to understand without the
  relevant group theory context. So I thought I#(apostrophe)d write things down.

  = First isomorphism theorem

  Recall that in general we know linear maps are not bijective (i.e.
  isomorphisms). For any linear map $tau$, this theorem establishes an
  isomorphism between its image and its codomain modulo its kernel.

  Quick notation rundown, let $V$ be a vector space over a field $FF$ and $U$
  be a subspace of $V$. For $x,y in V$, let $x ~ y$ be a binary relation that
  is true when $y
  - x in U$. It#(apostrophe)s easy to show $~$ is an equivalence relation.
  $[x]$ or $overline(x)$ denotes the equivalence class with representative
  $x$, and the quotient set (read $V$ mod $U$) is
  $
    V slash U = {[x] | x in V}
  $
  In fact, the quotient set forms a vector space---the _quotient space_---under
  the operations $[x] + [y] = [x+y]$ and $lambda [x] = [lambda x]$. See
  #link(
    "https://en.wikipedia.org/wiki/Quotient_space_(linear_algebra)",
  )[Wikipedia]
  for further reading.

  Anyways, the theorem.

  *Theorem statement*: Let $tau : V -> W$ be a linear map. Then the map
  $
    overline(tau) : V slash ker tau & -> im tau space &&("where" overline(x) = [x]) \
    overline(x) & |-> tau(x) \
  $
  is a well defined isomorphism.

  What we#(apostrophe)re really saying here is just that when we mod out the
  kernel of any linear map, we can define an injective map to its image. Since
  it#(apostrophe)s trivially surjective over its image, it is an isomorphism.
  This is intuitively very natural when we consider our intuition about the
  kernel is.
]<rendermath>

#proof[
  #[
    The proof proceeds by first establishing that such a linear map exists and is
    well defined, then proving it#(apostrophe)s an isomorphism.

    Let $V$ and $W$ be vector spaces over a field $FF$. Let $tau : V -> W$ be a
    linear map. Let $U = ker tau$ (for simplicity of notation#(apostrophe)s
    sake). Then, by the
    #link(
      "https://en.wikipedia.org/wiki/Universal_property",
    )[universal property]
    of $V slash U$, there exists a unique, well defined linear map $overline(tau)
    : V slash U -> W$, given by $overline(tau)(overline(x)) = tau(x)$. That is, the following diagram commutes (where $pi$ is the canonical map from $V$ to $V slash U$ sending each element to its equivalence class).
  ]<rendermath>

  #figure(diagram(
    cell-size: 25mm,
    $
                                      V
                                      edge(tau, ->)
                                      edge("d", pi, ->) & W \
      V slash U edge("tr", exists!overline(tau), "-->")     \
    $,
  ))

  #[
    [editor#(apostrophe)s note: I have a proof of the universal property, but it is too large to fit in the margins.]

    This establishes the existence of the map $overline(tau)$ we desire, now we
    need to show it#(apostrophe)s both surjective and injective.

    We can easily see $overline(tau)$ is surjective, let $x in im tau$, then
    $exists y in V$ with $tau(y) = x = overline(tau)(x)$.

    To show injectivity, we use the fact that an injective linear map has the trivial subspace ${0}$ as its kernel. Suppose $overline(x) in ker overline(tau)$. Then $overline(tau)(overline(x)) = 0_W$, so $tau(x) = 0_W$ by definition. Then $x in ker tau$, so $overline(x) = overline(0)$. Note that this is because
    $
      overline(0) = {x in V | x - 0 in ker tau} = ker tau.
    $
    Hence $ker overline(tau) = {overline(0)}$ so it is injective. Therefore,
    it#(apostrophe)s an isomorphism between $V slash U$ $=$ $V slash ker tau$
    and $im tau$.
  ]<rendermath>
]

= Second isomorphism theorem
