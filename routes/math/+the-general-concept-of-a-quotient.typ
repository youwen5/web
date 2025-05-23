#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(day: 19, year: 2025, month: 5),
  location: "Santa Barbara, California",
  title: "The general concept of a quotient",
)

#let definition(body) = [
  #strong[Definition.] #body
]

In grade school all of us learn that a quotient is name of the result returned
from a division operation. I feel that it is a learning opportunity for us to
examine other notions of #quote[quotient] in math, to get a picture of what
mathematicians mean when they say math is about generalizing.

#definition[
  Let $A$,$B$ be sets. Let $x in A$ and $y in B$. A _binary relation_ on $x$
  and $y$ assigns a truth value to every $x ~ y$.
]

#definition[
  1. A binary relation on a set $X$ is called _reflexive_ if $forall x in X$, $x ~ x$.
  2. A binary relation on a set $X$ is called _symmetric_ if $forall x,y in X$, $x ~ y$ implies $y ~ x$.
  3. A binary relation on a set $X$ is called _transitive_ if $forall x,y,z in X$, if $x ~ y$ and $y ~ z$, then $x ~ z$.
]

#definition[
  An _equivalence relation_ is a binary relation that is reflexive, symmetric, and transitive.
]

Equivalence relations help us generalize the notion of a quotient.

Let $V$ be an $FF$-vector space. Let $U subset.eq V$ be a subspace of $V$. Define a binary relation $~$ on $V$ by
$
  x ~ y <==> x - y in U
$
It#(apostrophe)s easy to see that $~$ is an equivalence relation, that is,
it#(apostrophe)s reflexive, symmetric, and transitive.

#definition[
  The _quotient set_ is called #quote[V modulo U], and written with the notation
  $
    V slash U = {[x] | x in V}
  $
]

The _quotient map_, or _canonical projection_ is
$
  pi : V & -> V slash U \
       x & |-> [x]      \
$
In other words, the map $pi$ takes you from $x$ to its equivalence class.

It#(apostrophe)s not a coincidence that $V slash U$ is called the quotient set
and written with that slash sign, like division. In general, when we think
about equivalence classes in a set, we can imagine a more general idea of the
concept of objects in the set being equal to zero under a modulus.
