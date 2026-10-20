---
title: "Effective enumerations and the universal machine"
published: 2026-10-18
---

#import "@preview/html-shim:0.1.0": *
#import "@preview/zen:0.6.0": zen

#show: body => context if target() == "html" {
  html-shim(body)
} else {
  zen(body)
}

We will introduce the idea of enumerating all computable partial functions and
then defining a universal machine that computes any program description on
arbitrary inputs.

= Notions

#definition[
  A partial function $f : A harpoon B$ is defined on some subset $D subset.eq
  A$ of its domain. When $x in D$, then we say $f(x) = y$ converges to $y$, and
  write $f(x) = arrow.b y$. When $x in.not D$, we say that $f(x)$ diverges and
  write $f(x) arrow.t$.
]

Say a partial function is computable or recursive (same meaning) if it is
constant or can be defined from substitution, composition, primitive recursion,
or minimization of other computable partial functions.

We will consider only partial functions $f : NN^n harpoon NN$.

Now we play with the idea of encoding data structures into partial functions.
Let $x_1, x_2, ..., x_n in NN$. Let $chevron dot, dot, dots, dot chevron.r$ be
an $n$-ary total function that does the following:

1. Let $p_1, p_2, ...$ be a fixed ascending sequence of primes where $p_(i +
  1)$ is the next prime after $p_i$ and $p_1 = 2$.
2. Let $chevron x_1, x_2, ..., x_n chevron.r = product_(i = 1)^n p_i^(x_i + 1)$.

#definition[
  We call $chevron x_1, ..., x_n chevron.r$ a *sequence code*.
]

We want to show sequence coding is computable.

#proposition[
  The function $rho : NN -> NN$ giving $rho(n)$ is the $n^"th"$ prime number,
  where $rho(1) = 2$.
]

#proof[
  Define $rho$ by primitive recursion from $g$ and $h$:
  $
    & g(arrow(x), 0) = 1 \
    & h(arrow(x), t, y + 1) = mu z[z > t and "Prime"(z)].
  $
  An easy induction shows that $rho$ computes the desired result. We'll take
  for granted that $"Prime"$ is a decidable relation.
]

#proposition[
  Sequence coding is computable.
]

#proof[
  Define $chevron x_1, ..., x_n chevron.r$ by primitive recursion from $g$ and
  $h$.

  $
    & g(x_1, ..., x_n, 0) = 1 \
    & h(x_1, ..., x_n, t, y + 1) = t dot (rho(y + 1))^(x_y + 1).
  $
]

The whole point of sequence coding is to leverage the unique factorization of
primes to encode sequences as single naturals. Now it should be obvious how to
define functions to extract the element at index $i$ in a sequence, count the
length of the sequence, etc. Let $s$ be a sequence code. Define the relation
$"Seq"(s)$ for if $s$ is a valid sequence code, and the partial function
$"lh"(s)$ to count the length of the code. Let $(s)_i$ be the element at index
$i$ (0-indexed).

#definition[
  An *unlimited register machine* (URM) will refer to the definition in
  #link(
    "https://en.wikipedia.org/wiki/Register_machine",
  )[this Wikipedia article.]
]

To summarize, we are using a URM that has an unlimited supply of natural number
registers which can be addressed using $0$-based indexing and supports zero,
successor, transfer, and jump instructions. However, no indirect addressing is
allowed, i.e. we cannot have a program compute a "variable" $n$ and say "access
the register $n$."

A URM is basically an abstract machine that is often easier to analyze than a
Turing machine. Keeping with Church-Turing, it is of course equivalent to TMs.
We will work with URMs.

Since we have the basic list data structure via sequence coding, we can give a
sketch towards how to simulate any URM using only recursive partial functions.
The idea is that a URM program is simply a finite, enumerable list of
instructions $I_0, I_1, I_2, ..., I_n$. Each instruction is exactly one of the
four aforementioned types alongside the parameters. The zero and successor
instructions both take a single parameter, the register index to operate on,
while the transfer instruction takes two parameters (copying the value of the
first register to the second), and the jump instruction takes two register
indices and an instruction index.

We basically just want to encode the registers as a sequence code. Each
register holds a natural number, corresponding to the natural number entries of
our sequence code. Then, we want to somehow encode each instruction. We can do
this by fixing a number for each instruction (e.g. 1 corresponds to zero, 2
corresponds to successor, and so on). Then, an instruction is a sequence code
whose first entry is the instruction number and the entries after are its
parameters (if any). Now the entire program code $I_1, I_2, ..., I_n$ might be
encoded as $chevron |I_1|, |I_2|, ..., |I_n| chevron.r$ where $|I_k|$ is the
encoding of the instruction. That is, every URM program description can be
represented as a single natural number $e$. When $P$ is a URM program and $e$ is the corresponding encoding, we say that $e$ is *code* for $P$, and we write
$
  f^((n))_e (arrow(x))
$
to mean the $n$-ary partial function computed by the URM coded by $e$, i.e. $P$.

Finally, we want to encode a single snapshot of the URM executing, capturing
all its state. For each snapshot, we might store the current instruction (with
its parameters) and the current register state in a single sequence code. Then
we can represent the full computation trace of a URM by building a list of each
of its state snapshots as the machine executes. We can build decidable checks
for whether a computation state follows from a previous computation state, and
whether a state is an initial or halting state. These checks, when combined,
can verify whether a computation trace is accurate.

The general idea is that we can (with a lot of bookkeeping) build up
increasingly complex relations that encode the structure of URM computations.
The prior section is more just food for thought and a cursory sketch to show
how it's plausible the rest of this article can be rigorously justified.

Let us define the following.
- $"PC"(e) <=>_"df"$ $e$ is a valid program code.
- $"InitialState"(s) <=>_"df"$ $s$ is an initial state.
- $"HaltState"(s) <=>_"df"$ $s$ is a halting state.
- $"CmpState"(e, arrow(x), j, k) <=>_"df"$ #[The computation $k$ follows from $j$ in program $e$ executed on input $arrow(x)$].

We take for granted that all of these relations are decidable, noting that our
previous sketches are reasonably convincing evidence that they wouldn't be too
hard to define.

= The Kleene $T$-predicate

The idea of the Kleene $T$-predicate (which is just a fancy name for a
particular relation) is to construct a decidable relation that checks whether a
URM program code $e$ run on an input $arrow(x)$ is correctly described by a
sequence of computation steps stored in a sequence code $y$. A search process
can then find this correct computation sequence (if the partial function being
computed converges), or otherwise it will never find it (i.e. no terminating
computation sequence exists, i.e. the function diverges).

Formally, fix $n$ and then
$
  T_n (e, arrow(x), y) <=>_"df" "PC"(e) &and "Seq"(y) \
  &and (forall i < "lh"(y) - 2)("CmpState"(e, arrow(x), i, i + 1)) \
  &and "InitialState"((y)_0) \
  &and "HaltState"((y)_("lh"(y - 1))).
$

Then define
$
  U(y) = (y)_("lh"(y) - 1, 2, 0).
$

Then $f^((n))_e (arrow(x)) = U(mu y [T_n (e, arrow(x), y)])$.

== Applications

#definition[
  Let $f_1, f_2, f_3, ...$ be a sequence of $n$-ary partial functions. We say
  they are *uniformly computable* if the function $F : NN^(n+1) -> NN$ defined
  below is computable.
  $
    F(e, arrow(x)) := f_e (arrow(x)).
  $
]

The function $U$ in the Kleene $T$-predicate section is closely related to the
idea of a _universal machine_ that computes any partial function. We take for
granted in this section that a URM can compute any recursive partial function.
(It is just a matter of tedious bookkeeping to show that any of the recursive
definition schemes can be run on a URM.)

Consider the sequence $phi^((n))_1, phi^((n))_2, ...$ where
$
  phi^((n))_e (arrow(x))
$
equals the $n$-ary function computed by the program coded in $e$ on $arrow(x)$.
Then our work above shows that this sequence contains _every_ URM-computable
partial function. Also, the $(n+1)$-ary function below,
$
  psi^((n))_U (e, arrow(x)) = U(mu y [T(e, arrow(x), y)]) = phi^((n))_e (arrow(x)),
$
shows that $phi^((n))_1, phi^((n))_2, ...$ is uniformly computable. We call
this sequence an *effective enumeration*.

Also, since $psi$ is in particular computable, $psi$ has a URM program
computing it. Let $P$ be the program. Then
$
  f_P^((n)) (e, arrow(x)) = phi_e^((n)) (arrow(x)).
$
In English, this says that $P$ computes an $n$-ary partial function which takes
in a program code $e$ and input $arrow(x)$ and outputs the result of running
the code $e$ on $arrow(x)$. That is, $P$ can simulate the output of any URM. As
any partial recursive function is also URM-computable, we call $P$ the
*universal machine for computable partial functions*.
