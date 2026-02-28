---
title: "Deriving the Y-Combinator"
published: 2026-02-28
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#let theorem(body) = callout("Theorem", body)

_Not that $bold(y)$-combinator_.

Curry's "paradoxical" $bold(y)$-combinator gives a fixed-point for every single
_term_ in the simply untyped $lambda$-calculus. (Recall that in the untyped
$lambda$-calculus, as there is no notion of a term having type "function" or
"variable," every term may be regarded being allowed to have terms applied to
it, even in nonsensical cases, which is in fact the crux of the derivation.)

= Notions

For our purposes, our simply untyped $lambda$-calculus will be a $lambda
beta$-theory, in the equational theory sense, in that it consists of the
standard rules of the lambda calculus with the $beta$-conversion rule.

A fixed point of a term $f$ is simply any term $x$ such that $f x = x$.
Additionally, if there exists a combinator $s$ such that for any terms $f$ and
$z$ we have $f (s z) = s z$, i.e. $s z$ is a fixed point of $f$, then we say $s$
is a *fixed-point combinator*.

= The Y

We proceed to derive the $bold(y)$-combinator as the proof of this theorem.

#theorem[
  Every term in the simply untyped $lambda$-calculus has a fixed point,
  moreover, we can find an explicit formula for such fixed points.
]

Let $f$ be any term. We basically are trying to solve for some term $X$ in the
equation
$
  X = f X.
$

There is no way to do this, since $X$ appears in both sides. We can try naively to let $x$ be arbitrary and instead write
$
  X' x = f x.
$

This doesn't help us solve the problem at all, but it gives a hint, namely, we
see that $X' X' = f X'$. If only the right side was $f (X' X')$, then we would
be done!

The trick is now to use self-reference (or some other "paradoxical" trick could
work, but this is easy). Instead, write
$
  X'' x = f (x x)
$
and see that $X'' X'' = f(X'' X'')$. A fixed point! Now what could $X''$ be?
It's so obvious, it might as well be written on the page. $X'' = lambda x . f(x
  x)$ obviously works. Now just write out $X'' X''$ and bind $f$ and you recover
the classical $bold(y)$-combinator!
