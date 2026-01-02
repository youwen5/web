---
title: "Three Isomorphism Theorems in Linear Algebra"
published: 2025-06-19
description: "A proof of the first three isomorphism theorems for linear algebra in particular."
---

#import "@preview/html-shim:0.1.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: html-shim

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

When I first learned about these they were difficult to understand or
justify. So I thought I'd write things down, now that
I've figured them out. These are particular cases of the more
general
#link("https://en.wikipedia.org/wiki/Isomorphism_theorems")[isomorphism
  theorems] in abstract algebra.

Let $V$, $W$ be vector spaces over a field $FF$. Then we have the following
isomorphisms ($tilde.equiv$).

#table(
  columns: 2,
  table.header([Theorem], [Statement]),
  [1st],
  [Given any linear map $tau : V -> W$, $V slash ker tau tilde.equiv im tau$],

  [2nd], $U slash (U inter W) tilde.equiv (U + W) slash W$,
  [3rd], $(V slash U) slash (W slash U) tilde.equiv V slash W$,
)

= First isomorphism theorem

Recall that we know linear maps are not in general bijective (i.e. not
isomorphisms). However, for any linear map $tau$, the first theorem gives us
an isomorphism between its domain _modulo its kernel_ and its image.

Quick notation refresher: let $V$ be a vector space over a field $FF$ and $U$
be a subspace of $V$. For $x,y in V$, let $x ~ y$ be a binary relation that
is true when $y
- x in U$. It's easy to show $~$ is an equivalence relation.
$[x]$ or $overline(x)$ denotes the equivalence class with representative
$x$,
$
  [x] = {y in V | x ~ y} = {y in V | y - x in U}
$

The quotient set (read $V$ mod $U$) is
$
  V slash U = {[x] | x in V}
$
In fact, the quotient set forms a vector space---the _quotient space_---under
the operations $[x] + [y] = [x+y]$ and $lambda [x] = [lambda x]$. See
#link(
  "https://en.wikipedia.org/wiki/Quotient_space_(linear_algebra)",
)[Wikipedia]
for further reading.

Anyways, the first theorem.

*Theorem statement*: Let $tau : V -> W$ be a linear map. Then the map
$
  overline(tau) : V slash ker tau & -> im tau space &&("where" overline(x) = [x]) \
  overline(x) & |-> tau(x) \
$
is a well defined isomorphism.

What we're really saying here is just that when we mod out the
kernel of any linear map, we can define an injective map to its image. Since
it's trivially surjective over its image, it is an isomorphism.
This is intuitively very natural when we consider our intuition about the
kernel is.

#proof[
  The proof proceeds by first establishing that such a linear map exists and is
  well defined, then proving it's an isomorphism.

  Let $V$ and $W$ be vector spaces over a field $FF$. Let $tau : V -> W$ be a
  linear map. Let $U := ker tau$ (for simplicity of notation's
  sake). Then, by the
  #link(
    "https://en.wikipedia.org/wiki/Universal_property",
  )[universal property]
  of $V slash U$, there exists a unique, well defined linear map $overline(tau)
  : V slash U -> W$, given by $overline(tau)(overline(x)) = tau(x)$. That is, the following diagram commutes (where $pi$ is the canonical map from $V$ to $V slash U$ sending each element to its equivalence class).
]

#figure(diagram(
  cell-size: 25mm,
  $
                                    V
                                    edge(tau, ->)
                                    edge("d", pi, ->) & W \
    V slash U edge("tr", exists!overline(tau), "-->") \
  $,
))

This establishes the existence of the map $overline(tau)$ we desire, now we
need to show it's both surjective and injective.

#btw[
  editor's note: I have a proof of the universal property, but it is too large to fit in the margins.
]

We can easily see $overline(tau)$ is surjective, let $x in im tau$, then
$exists y in V$ with $tau(y) = x = overline(tau)(overline(x))$.

To show injectivity, we use the fact that an injective linear map has the trivial subspace ${0}$ as its kernel. Suppose $overline(x) in ker overline(tau)$. Then $overline(tau)(overline(x)) = 0_W$, so $tau(x) = 0_W$ by definition. Then $x in ker tau$, so $overline(x) = overline(0)$. Note that this is because
$
  overline(0) = {x in V | x - 0 in ker tau} = ker tau.
$
Hence $ker overline(tau) = {overline(0)}$ so it is injective. Therefore,
it's an isomorphism between $V slash U$ $=$ $V slash ker tau$
and $im tau$.

= Second isomorphism theorem

*Theorem statement*: Let $V$ be an $FF$ vector space. Let $U$, $W$ be subspaces of $V$. We have the following isomorphism.
$
  U slash (U inter W) tilde.equiv (U+W) slash W
$

#proof[
  This proof is a little different. First we're going to show the
  following linear map exists.
  $
    tau : U & -> (U + W) slash W \
          x & |-> [x]_W \
  $
  To see that it exists and is linear, simply note it is the composition
  $
    U attach(arrow.hook, t: iota) U + W attach(t: pi_W, ->) (U+W) slash W.
  $
  (Where $iota : U -> U + W$ is the inclusion map and $pi_W$ is the canonical map sending each element to its equivalence class.)

  We know $iota$ and $pi_W$ to be linear, so the composition is also a linear
  map.

  Now that we've established the existence of such a linear map
  $tau$, the idea is to first show that $tau$ is surjective (that is, its
  image is its codomain $(U+W) slash W$). Then we show that $ker tau = U
  inter W$, and apply the first isomorphism theorem to obtain our desired
  isomorphism.

  Suppose $s in (U+W) slash W$. Then $s = [x + y]_W$, for some $x in U$ and
  $y in W$. But $[x+y]_W = [x]_W$, because $[y]_W = overline(0)$. So $s =
  tau(x)$, and $tau$ is surjective.

  Now let $x in U$.
  $
    x in ker tau & <==> tau(x) = overline(0) \
                 & <==> [x]_W = overline(0) \
                 & <==> x - 0 in W \
                 & <==> x in U inter W \
  $
  Therefore $ker tau = U inter W$. Since we showed $tau$ is surjective, $im tau = (U+W) slash W$. Then, by the first isomorphism theorem, there is an isomorphism
  $
      U slash (ker tau) & tilde.equiv im tau \
    U slash (U inter W) & tilde.equiv (U+W) slash W \
  $
]

= Third isomorphism theorem

This one gives us a sort of "cancellation of fractions" for our
quotients.

*Theorem statement*: Let $V$ be an $FF$-vector space. Let $U$, $W$ be subspaces of $V$. Suppose $U subset.eq W$. Then
$
  (V slash U) slash (W slash U) tilde.equiv V slash W
$
Just imagine you're cancelling
$
  (V slash cancel(U)) / (W slash cancel(U)) tilde.equiv V slash W
$

#proof[
  Again we're going to try to define a linear map that lets us
  apply the first isomorphism theorem. No tricks this time, so
  we'll attempt to directly construct a linear map $tau$ and show
  it is well defined.

  Let $tau$ be a linear map
  $
    tau : V slash U & -> V slash W \
              [x]_U & |-> [x]_W \
  $
  We need to show $tau$ is well defined, that is, it doesn't
  depend on choice of representatives. Suppose $[x]_U, [x']_U in V slash U$.
  Then $x - x' in U$, so $x - x' in W$. So $x = [x']_W$. Similarly $x' =
  [x]_W$. So $tau$ is well defined.

  Next we show linearity. This is just a simple manipulation. Let $lambda,mu in FF$, $[x]_U, [y]_U in V slash U$. Then
  $
    tau(lambda [x]_U + mu [y]_U) = tau([lambda x + mu y]_U) \
    = [lambda x + mu y]_W = lambda [x]_W + mu[y]_W = lambda tau([x]_U) + mu tau([y]_U)
  $

  Now we need surjectivity, which is trivial. Suppose $[x]_W in V slash W$,
  then obviously $tau([x]_U) = [x]_W$.

  Finally we need to show $ker tau = W slash U$.
  $
    ker tau & = {[x]_U in V slash U | [x]_W = [0]_W} \
            & = {[x]_U in V slash U | x in W} \
  $
  But actually that last set is precisely $W slash U$.

  With all the pieces in place, we now apply the first isomorphism theorem, and we are done
  $
      (V slash U) slash (ker tau) & tilde.equiv im tau \
    (V slash U) slash (W slash U) & tilde.equiv V slash W \
  $
]
