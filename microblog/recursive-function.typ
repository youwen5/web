---
pagetitle: "General Recursive Functions"
published: 2026-09-09
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#definition[
  A *partial function* from $NN -> NN$ is a function $f : D -> NN$ for some $D
  subset.eq NN$. We write $f : NN harpoon NN$.
]

For $x in NN$ we write $f(x) arrow.b$ to mean $x in D$ and $f(x) arrow.t$ to
mean $x in.not D$. "Converges," "Diverges."

#abuse[
  If $x in D and f(x) = y$ then we write $f(x) arrow.b = y$.
]

$"dom"(f) = {x | f(x) arrow.b}$, $"ran"(f) = {y(exists x in NN, f(x) arrow.b =
    y)}$.


#definition[
  If $f : NN harpoon NN and "dom"(f) = NN$ we say $f$ is *total*. Write $f : NN
  -> NN$ (like usual).
]

If $f, g : NN harpoon NN$ we say $f = g$ if
$
  forall x [(f(x) arrow.t and g(x) arrow.t) or (f(x) arrow.b and g(x) arrow.b and f(x) = g(x))].
$
(Symbol soup for they agree on convergence, and value if converges. Funext for partials.)

= Recursive partial functions

Some $n$-ary partial functions are "clearly" effectively calculable (you could
imagine a computer doing these easily).

- Composition: if we already have two effectively calculable programs
  (functions), then composing them is trivial.

- For $n in NN$, let $C_0^n : NN^n -> NN$ be $C_0^n (arrow(x)) = 0$. Let $s : NN -> NN$ be $s(x) = x+1$. ($s$ for _successor_.)

- For $k < n in NN$, let $pi^n_k : NN^n -> NN$ be the "$k$-th projection"
  $
    pi^n_k (x_0, ..., x_(n-1)) = x_k.
  $

- For $k, n in NN$, $h : NN^k harpoon NN$, $g_0, ..., g_(k-1) : NN^n harpoon NN$, let
  $
    f(arrow(x)) = h(g_0 (arrow(x)), g_1 (arrow(x)), ..., g_(k-1) (arrow(x))) : NN^n -> NN.
  $
  Here we say $f$ is *defined by substitution* from $h, g_0, ..., g_(k-1)$.


Let $cal(C)$ be the family of partial functions $NN^* -> NN$. An additional
rule:

- Recursion: let $h : NN -> NN$, $k in NN$. Define $f : NN -> NN$ by $f(0) =
  k$ and $forall x, f(x + 1) = h(f(x))$.

  More generally, for $n in NN$, $g : NN^n -> NN$, $h : NN^(n + 2) -> NN$,
  define $f : NN^(n+1) -> NN$. For $arrow(x) in NN^n$, take $f(arrow(x), 0) =
  g(arrow(x))$, and $forall y, f(arrow(x), y + 1) = h(arrow(x), f(arrow(x), y),
    y)$.

  Here we say that $f$ is *defined by primitive recursion* from $g$ and $h$. If $g, h in cal(C)$, then $f in cal(C)$.

#example[
  $+ : NN^2 -> NN$ is in $cal(C)$.
]

#proof[
  Use primitive recursion,
  $
                    x + 0 & = x \
    forall y, x + (y + 1) & = s(x + y) = s(pi_1^3(x, x+y, y)).
  $
]

In the proof above, explicitly speaking, we chose $g(x) = "id"_NN$. The choice
of $h$ is also clear. Here $arrow(x) in RR$, so given $f(x, y + 1) = x + (y +
  1)$, a suitable choice is $h = s compose pi_1^3$, since $h(x, x + y, y) =
s(x+y) = x
+ (y + 1) = f(x, y + 1)$.

Beyond just satisfying the symbolic constraints we attempt to give an intuitive
explanation for why this is a clear choice. We should interpret the $(n+1)$-ary
function $f$ as the familiar _for loop_. The first $n$ parameters constitute
the vector $arrow(x)$, and the $(n+1)^"th"$ argument can be seen as the loop
index $i$. We should view $arrow(x)$ as some immutable auxiliary data that the
loop can access throughout its iterations. Indeed, notice that $arrow(x)$ is
passed unchanged throughout every recursive step of $f$, $g$, and $h$.

The $n$-ary function $h$ can be interpreted as an initial value at $i = 0$, and
the $(n+2)$-ary function $h$ is the loop body. The $(n+1)^"th"$ argument of $h$
is some value passed down from the previous iteration of the loop. The way I
think about it is that at index $i$ of the loop, which is $f(arrow(x), i)$, we
can pass on some value to the next iteration $i + 1$. We can therefore access
the value passed to us by the previous iteration $i - 1$, which is why
$f(arrow(x), y + 1) = h(arrow(x), f(x, y), y)$.

Once we digest primitive recursion from the for loop perspective, it becomes
more palatable as a "primitive" form of recursion. Essentially, instead of a
recursive function (in the colloquial sense) being able to arbitrarily call
itself in its body, a primitive recursive function $f(arrow(x), y)$ can only
obtain the value of $f(arrow(x), y - 1)$ in its body, and the base case is
guaranteed to be when $y = 0$. In this view, $g$ and $h$ are merely auxiliary
functions to make the formalism work out.

Now the choice of $h = s compose pi^3_1$ is clear. For $x + y$, we just need a
for loop to add $1$ to $x$, $y$ times. We don't need the initial input $x$, and
we don't need the index $y$. So we use $pi^3_1$ to choose the prior value of
the "loop," and then we add one to it (via the successor function). The initial
value of the loop is clearly $h(x) = x$ itself. Now the function $f$ defined by
primitive recursion can be interpreted as a for loop with an accumulator
variable initialized at $x$, at each following iteration adding $1$ to the
accumulator, running for a total of $y + 1$ times. (The first iteration where
$x$ is initialized is interpreted as $x + 0$, so the loop adds one to $x$ a
total of $y$ times, computing $x + y$ in the end.)

Primitive recursion for partials: for partial functions $g : NN^n harpoon NN$,
$h : NN^(n+2) harpoon NN$, the function $f : NN^(n+1) harpoon NN$ *defined by
primitive recursion* from $g$ and $h$ is given by
$
  forall z, f(arrow(x), 0) arrow.b &= z <==> g(arrow(x)) arrow.b = z \
  forall y, f(arrow(x), y+1) arrow.b &= z <==> exists m, [f(arrow(x), y) arrow.b = m and h(arrow(x), m, y) arrow.b = z].
$

Just means that when working with partials we need to take care of convergence.

- Let $n in NN$, $g : NN^(n+1) -> NN$. Define $f : NN^n -> NN$ by
  $
    f(arrow(x)) arrow.b = y &<==> y "is the least natural number s.t." g(arrow(x), y) = 0 \
    &<==> g(arrow(x), y) = 0 and forall z < y, g(arrow(x), z) != 0 \
    f(arrow(x)) arrow.t &<==> forall y, g(arrow(x), y) != 0.
  $


  If $y in cal(C)$, we'll put $f in cal(C)$. Notation: $f(arrow(x)) = underbrace(mu y, "'least'" y) [g(arrow(x), y) = 0]$.

  We say that $f$ is defined from $g$ by *minimization*.

  In the partial case, for $g : NN^(n+1) harpoon NN$, define $f(arrow(x)) = mu y[g(arrow(x), y) = 0]$ by
  $
    f(arrow(x)) arrow.b = y <==> g(arrow(x), y) arrow.b = 0 and forall z < y, [g(arrow(x), z) arrow.b and g(arrow(x), z) != 0].
  $

#definition[
  Call a family $cal(C)$ of partial functions $NN^* harpoon NN$ *recursively
  closed* if it satisfies all the previous construction axioms.
]

#definition[
  $
    cal(R) = inter.big_(cal(C) "is recursively closed") cal(C).
  $
  If $f in cal(R)$, we say $f$ is *recursive*.
]

Equivalently, $f$ is recursive iff it can be defined from $s$, $C_0^n$,
$pi_k^n$, using finitely many applications of substitution, primitive
recursion, and minimization.

Non-mathematical claim: recursive functions are _effectively calculable_. If
you believe in the Church-Turing Thesis, then recursive functions are exactly
the functions which can be computed by effective methods (e.g.
Python-computation).
