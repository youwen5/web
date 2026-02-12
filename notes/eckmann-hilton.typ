---
title: "The Eckmann-Hilton Argument"
published: 2026-02-13
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

#let theorem(body) = callout("Theorem", body)

The Eckmann-Hilton argument causes many seemingly more complex structures to
collapse into simpler ones. For instance, the fundamental group of any
topological space is always Abelian.

#theorem[
  Let $S$ be a set which is a magma under two unital binary operations,
  $plus.o$ and $times.o$. Suppose one is a homomorphism for the
  other. Then $plus.o = times.o$ and moreover $S$ is a commutative
  monoid under these operations.
]

We usually speak of homomorphisms as unary functions compatible with a
structure, e.g. $f : S -> S$ with $f(x plus.o y) = f(x) plus.o f(y)$.
Binary homomorphisms look like this:
$ (a times.o b) plus.o (c times.o d) = (a plus.o c) times.o (b plus.o d). $
It seems strange that the $b$ and $c$ "swap" positions, but this is the binary
analog to the notion of the homomorphism being a compatible operation, such
that $a$ times $b$ plus $c$ times $d$ is the same as $a$ plus $c$ first
times $b$ plus $d$.

#btw[
  A set with a unital binary operation is called a _unital magma_. Unital means
  that the operation has a unique left and right identity, and a simple
  argument shows that these identities in fact coincide.
]

#proof[
  The key step is to show that the identities of both operations coincide. Let $bb(1)_plus.o$ and $bb(1)_times.o$ be the identities of $plus.o$ and $times.o$ respectively, then
  $
    (bb(1)_times.o plus.o bb(1)_plus.o) times.o (bb(1)_plus.o plus.o bb(1)_times.o) = bb(1)_times.o = (bb(1)_times.o times.o bb(1)_plus.o) plus.o (bb(1)_plus.o times.o bb(1)_times.o) = bb(1)_plus.o.
  $

  The rest of the proof should follow easily. The setup
  $
    forall a, b in S, (a plus.o bb(1)) times.o (bb(1) plus.o b)
  $
  gives that $plus.o = times.o$ and similar arguments give associativity and
  commutativity, which show that $S$ under the operations is indeed a
  commutative monoid and concludes the proof.
]

Another consequence of Eckmann-Hilton is that a monoid object in the category
of monoids *Mon* is a commutative monoid, in fact this can be taken as a
category theoretic formulation of the argument itself.
