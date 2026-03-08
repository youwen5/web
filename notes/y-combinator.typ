---
title: "Deriving the Y-Combinator"
published: 2026-02-28
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#let theorem(body) = callout("Theorem", body)

_Not that Y-combinator_.

#link("https://en.wikipedia.org/wiki/Haskell_Curry")[Haskell Curry]'s
"paradoxical" $bold(y)$-combinator gives a fixed-point for every single _term_
in the untyped $lambda$-calculus. (Recall that in the untyped
$lambda$-calculus, as there is no notion of a term having type "function" or
"variable," every term may be regarded being allowed to have terms applied to
it, which is in fact the crux of the derivation.)

= Notions

For our purposes, our untyped $lambda$-calculus will be a standard $lambda
beta$-theory, in the equational theoretic sense, in that it consists of the
standard rules of the lambda calculus with the $beta$-conversion rule.

#btw[
  This tidbit is not really necessary or too interesting, but I thought I'd
  point it out. The $beta$-conversion rule is often called $beta$-reduction,
  but there's a semantic distinction here. $beta$-conversion is defined by a
  _binary relation_ called $beta$, which relates
  $
    (lambda x . z) s space beta space z[s\/x].
  $
  Here, $z[s\/x]$ is not a distinct term in the lambda calculus but represents
  substituting all free occurrences of $x$ with $s$ in the term $z$, while
  avoiding unintended capture of free variables via $alpha$-conversion.

  For any relation $R$, we can define the _compatible closure_, an induced
  relation denoted $attach(->, br: R)$. We call it the $R$-reduction. It's
  simply the relation itself, along with relating $s u attach(br: R, ->) t u$
  if $s attach(->, br: R) t$ (reduction on the left), a similar rule for
  reduction on the right, and reduction under abstraction.

  When studying $lambda$-calculi, we are usually interested in the
  $beta$-reduction.
]

A lambda abstraction is a term of the form $lambda x . s$. A combinator is a
lambda abstraction with no free terms.

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

Since $X$ appears in both sides, and it is not clear (nor true) that every term
has the same fixed point, it's pretty obvious our solution is going to contain
the term itself $f$. Therefore, we should search for a fixed-point combinator. We
can first naively try the combinator that is the term itself. Let $x$ be
arbitrary (free) and instead write $ X' x = f x. $

This doesn't actually help us solve the problem at all, but it gives a hint,
namely, we see $f X' = X' X'$. If only the left side was $f (X' X')$, then we
would be done!

The key trick is to use self-reference. Write the combinator $X''$ that gives
$
  X'' x = f (x x)
$
and see that $X'' X'' = f(X'' X'')$. A fixed point! Now what could $X''$ be?
$X'' = lambda x . f(x x)$ obviously works. Now just write out $X'' X''$ and
bind $f$ and you recover the classical $bold(y)$-combinator!

$
  bold(y) = lambda f . (lambda x . f(x x)) (lambda x . f(x x)).
$

#emoji.confetti
#emoji.confetti
#emoji.confetti
