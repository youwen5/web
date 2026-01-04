---
title: Universal constructions and the universal property of quotients
published: 2026-01-04
---

#import "@preview/html-shim:0.1.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: html-shim

This is going to be a short introduction to the concept of how we may create a
_universal construction_ of a certain concept through defining a _universal
property_. We'll demonstrate by defining the _universal property of quotients_,
to characterize the concept of taking a quotient, e.g. a quotient group in
group theory or quotient space in linear algebra.

= Notions

From #link("https://en.wikipedia.org/wiki/Universal_property")[Wikipedia]:

#blockquote[
  In mathematics, more specifically in category theory, a *universal property* is a
  property that characterizes up to an isomorphism the result of some
  constructions. Thus, universal properties can be used for defining some objects
  independently from the method chosen for constructing them. For example, the
  definitions of the integers from the natural numbers, of the rational numbers
  from the integers, of the real numbers from the rational numbers, and of
  polynomial rings from the field of their coefficients can all be done in terms
  of universal properties. In particular, the concept of universal property
  allows a simple proof that all constructions of real numbers are equivalent: it
  suffices to prove that they satisfy the same universal property.
]

The whole idea is that when we want to do a construction in mathematics, the
concrete details might be very messy (for example, for quotient groups, we may
reach for the notions of _coset_ or _fiber_), but any construction satisfying a
given universal property is going to give an equivalent result. _All there is
to know about the construction is already contained in the universal property_.

= The universal morphism

One way of formulating the universal property is as follows. Let $cal(C)$ and
$cal(D)$ be categories, $F : cal(C) -> cal(D)$ a functor between them, $A$
and $A'$ be objects in $C$, and $X$ be an object in $D$.

Then a _universal morphism_ from $X$ to $F$ is the unique pair $(A, u : X ->
  F(A))$, which has the following _universal property_:

For every morphism $f : X -> F(A')$, there is a unique morphism $h : A -> A'$
in $cal(C)$ such that the following diagram commutes.

#figure(diagram(
  cell-size: 20mm,
  $
                                    X
                                    edge(f, ->)
                                    edge("d", u, ->) & F(A') \
    F(A) edge("tr", F(h), "-->", label-side: #right) \
  $,
))

Here is a concrete example. Let $cal(C) = cal(D) = bold("Grp")$, the category with
groups as objects and group homomorphisms as morphisms. Now the functor $F :
bold("Grp") -> bold("Grp")$ is simply the identity functor. We let $X = G$ and $A = G slash
N$, where $G$ is an arbitrary group and $N lt.tri.eq G$ ($N$ is normal in $G$).

Now let $A' = H$, where $H$ is another group and let $f : G -> H$ be any group
homomorphism (morphism) between them. Then the universal morphism is $u : G ->
G slash N$. The universal property says that there is a unique morphism $h : G
slash N -> H$ such that the diagram above commutes, that is $f = h compose u$.

You may notice that this is a classic result about quotient groups in group
theory, and part of the proof of the
#link("https://en.wikipedia.org/wiki/Isomorphism_theorems")[first isomorphism
  theorem]! Here $u$ is the _canonical map_ $pi : G -> G slash N$ sending each $g
in G$ to its congruence class in $G slash N$. The diagram above closely
resembles this one which appears in many standard algebra textbooks (e.g.
Dummit and Foote).

#figure(diagram(
  cell-size: 20mm,
  $
                                                        G
                                                        edge(tau, ->)
                                                        edge("d", pi, ->) & H \
    G slash N edge("tr", exists!overline(tau), "-->", label-side: #right) \
  $,
))

OK, so what? The point is that this universal property characterizes _any_
construction of the quotient group _up to isomorphism_, which means any
construction of a quotient that satisfies the property is essentially the same.
In Dummit and Foote, quotients are formulated using
#link("https://en.wikipedia.org/wiki/Fiber_(mathematics)")[fibers], while a
more standard approach is to use
#link("https://en.wikipedia.org/wiki/Coset")[cosets], but with both
constructions we can show the universal property above, so both notions of
quotient are equivalent, and the quotients they define are isomorphic.

From another point of view, the universal property is the _definition itself_.
Thus, the diagram above could be seen as the definition of the quotient group.

The proof that the universal property characterizes constructions up to
isomorphism involves high-powered machinery I cannot reproduce here, but it's
essentially due to the
#link("https://ncatlab.org/nlab/show/Yoneda+lemma")[Yoneda lemma] (perhaps
among the most fundamental results in category theory) and how specifying all
the maps in and out of an object uniquely determines it.

= The comma category

An alternative, equivalent, and more abstract formulation of the universal
property involves defining a _comma category_ with a particular initial object.
A comma category essentially generalizes the slice category, as well as other
categories involving arrows such as the coslice category (which is the dual of
the slice category).

Firstly, we'll give a definition of the coslice category (there is a reason
why we chose the dual of the slice instead of the slice itself).

Let $A$ be an object in a category $cal(C)$. Then the *coslice* category is
denoted $(cal(C) arrow.b A)$ and represents the category of all the arrows
originating from $A$ #footnote[The slice category, being its dual, is
  accordingly the category of all the arrows going to $A$ instead, and is denoted
  $(A arrow.b cal(C))$.]. Objects in $(cal(C) arrow.b A)$ look like pairs $(B,
  h)$, where $B$ is an object in $cal(C)$ and $h$ is an arrow $B attach(->, t: h)
A$.

Morphisms from $(B,h) -> (B',h')$ are arrows $B attach(->, t: f) B'$ such that
the following diagram commutes.

#figure(diagram(
  $
    B edge("br", ->, h) edge("r,r", ->, f) &   & B' edge("bl", ->, h') \
                                           & A
  $,
))

That is, $h = h' compose f$.

Now we introduce the comma category, which essentially generalizes this notion.
Let $cal(A)$, $cal(B)$, $cal(C)$ be categories, and let $F$ and $S$ be functors
as such:

#figure(diagram(
  $
    A edge(->, S) & C & B edge("l", ->, T)
  $,
))

The *comma category* is denoted $(S arrow.b T)$ and has objects which are
triples of the form $(A, B, h)$ where $A$ is an object in $cal(A)$, $B$ is an
object in $cal(B)$, and $h$ is a morphism in $cal(C)$, specifically the arrow
$S(A) attach(->, t: h) T(B)$.

Morphisms in $(S arrow.b T)$ between $(A, B, h)$ and $(A', B', h')$ are pairs
$(f,g)$, where $f$ and $g$ are morphisms in $cal(A)$ and $cal(B)$ respectively,
such that $A attach(->, t: f) A'$ and $B attach(->, t: g) B'$, and the
following diagram commutes.

#figure(diagram(
  $
    S(A) edge(->, S(f)) edge("b", ->, h) & S(A') edge("b", ->, h', label-side: #left) \
    T(B) edge(->, S(g), label-side: #right) & T(B')
  $,
))

We can use this comma category to define a universal property. First, note that
we are not going to need all three categories, and the proof on Wikipedia uses
a different definition of comma category involving only two. For our more
general definition, we're simply going to "collapse" one category, namely
$cal(A)$.

Set $cal(A) = bold(1)$, where $bold(1)$ is the category with exactly one object
and one morphism. Then the functor $S$ simply maps $S(*) = C_*$ for some object
$C_*$ in $cal(C)$. The diagram becomes

#figure(diagram(
  $
    S(*) edge(->, S(id_cal(A))) edge("b", ->, h) & S(*) edge("b", ->, h', label-side: #left) \
    T(B) edge(->, S(g), label-side: #right) & T(B')
  $,
))

which simply reduces to

#figure(diagram(
  $
    &C_* edge("bl", ->, h, label-side: #right) edge("br", ->, h') \
    T(B) edge("r,r", ->, S(g), label-side: #right) && T(B')
  $,
))

Now note that all objects in $(S arrow.b T)$ are going to look like $(*, B,
  h)$, where $*$ is the only object in $cal(A)$, $B$ is some object in $cal(B)$,
and $h$ is a morphism from $C_* attach(->, t: h) B$, where $C_*$ is just some
fixed object in $cal(C)$. For brevity, we'll write $(B,h)$ to mean $(*, B, h)$
from now on.

Morphisms between $(B,h)$ and $(B', h')$ are still pairs of the form
$(f,g)$ where $f : * -> *$ is a morphism in $cal(A)$, and is thus necessarily
the identity morphism, while $g : h -> h'$ is a morphism in $cal(B)$. So for
brevity we'll just refer to morphisms $(f,g)$ by just $g$.

Now consider the object $(B, u : C_* -> T(B))$, where $B$ is an object in
$cal(B)$ and we may note that $u$ here is the same universal morphism from
earlier. Moreover, suppose that this object is _initial_, that is, there is a
unique arrow from $(B, u)$ to every object in $S arrow.b T$. This is sufficient
to once again define the universal property. For every object $(B', f : C_* ->
  T(B'))$, we have a _unique_ morphism $h : B -> B'$ (due to our initial object)
such that the following diagram commutes.

#figure(diagram(
  $
    C_* edge(->, u) & T(B) edge("d", ->, T(h), "dashed", label-side: #left) \
                    & edge("tl", <-, f, label-side: #left) T(B')
  $,
))

If you recall our previous definition of the universal property, this is
exactly that! That is, setting the initial object of our comma category leads
to an equivalent diagram and the same existence of unique morphism as our
original definition. (Technically, we only proved that setting this initial
object implies the universal property, we also need to prove the converse to
show the definitions are equivalent, but I won't do that here.)

Now consider our previous example of the universal property of the quotient
group. Once again, we are only working in the category of groups, so we may set
$cal(B) = cal(C) = bold("Grp")$. The functor $T$ is then the identity
endofunctor on $bold("Grp")$. The object $C_*$ is just some group, say $G :=
C_*$. With the universal morphism $u : G -> G slash N$, we define the
object $(G slash N, u)$ to be the initial object. Then take an arbitrary group
$H$, and a map $f : G -> H$. Then the pair $(H, f)$ is an object as well, so
there exists a unique morphism $h : G slash N -> H$ such that $h compose u =
f$. That is, this diagram commutes

#figure(diagram(
  cell-size: 20mm,
  $
                                             G
                                             edge(f, ->)
                                             edge("d", u, ->) & H \
    G slash N edge("tr", exists!h, "-->", label-side: #right) \
  $,
))

This is the exact same diagram from the previous section, and $u$ is again the
canonical map $pi$.

Finally, we note that in this degenerate case where $cal(B) = cal(C)$, $cal(A)
= bold(1)$, our comma category essentially reduced to the coslice category
introduced prior, so in fact to describe the universal property of quotients we
only needed the notion of coslice #footnote[Also note that when $cal(A) = cal(C)$,
  $cal(B) = bold(1)$, we instead obtain the slice category.]. This diagram, under these conditions,

#figure(diagram(
  $
    &C_* edge("bl", ->, h, label-side: #right) edge("br", ->, h') \
    T(B) edge("r,r", ->, S(g), label-side: #right) && T(B')
  $,
))

reduces to

#figure(diagram(
  $
    &C_* edge("bl", ->, h, label-side: #right) edge("br", ->, h') \
    B edge("r,r", ->, g, label-side: #right) && B'
  $,
))

where $B$, $B'$, and $C_*$ are all objects in a single category $cal(C)$.
Objects are of the form $(B, h : C_* -> B)$, and morphisms are of the form $g :
B -> B'$, which is essentially exactly how the coslice category was defined,
and the previous commutative diagram is just an inverted and relabeled version
of the one we drew for the coslice.

= Conclusion

The universal property we showed for quotient groups demonstrates how category
theory can trivially characterize certain constructions. Notice that, just by
replacing $bold("Grp")$ with $bold("Vect"_FF)$ (the category of vector spaces
over a field $FF$ with linear maps as morphisms), we obtain an equivalent
univeral property of _quotient spaces_. This gives a hint for how quotients and
the isomorphism theorems may be formulated in general via
#link("https://en.wikipedia.org/wiki/Universal_algebra")[the idea of universal
  algebra].
