---
title: "Computability and incompleteness"
published: 2026-04-21
description: "A short tour of the halting problem, Gödel incompleteness, and why they are connected."
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

Computability and incompleteness are two ways to formalize limits.

Computability asks: given a precisely specified procedure, what can be
calculated at all?

Incompleteness asks: given a sufficiently expressive formal theory, what can be
proved inside it?

The surprising part is that these limits are deeply related.

= Computability in one sentence

A function is computable if there is a finite mechanical procedure that always
halts and returns the correct output.

The standard models (Turing machines, lambda calculus, recursive functions) all
capture the same class of effectively computable functions. This is the content
behind the Church--Turing thesis.

= The halting problem

The canonical example of non-computability is the halting problem.

Suppose there were a program `Halts(P, x)` that always decides whether program
`P` halts on input `x`.

Construct a new program `D`:

1. On input `y`, compute `Halts(y, y)`.
2. If it says "halts", loop forever.
3. If it says "does not halt", halt immediately.

Now ask what `D` does on input `D`.

- If `Halts(D, D)` says "halts", then `D(D)` loops forever.
- If `Halts(D, D)` says "does not halt", then `D(D)` halts.

Both cases contradict correctness. So `Halts` cannot exist.

This diagonal argument establishes an absolute limit: there is no general
algorithm that decides halting for all programs.

= Incompleteness (Gödel)

Gödel's first incompleteness theorem (informally) says:

If a consistent, effectively axiomatized theory is strong enough to formalize
basic arithmetic, then there are true arithmetic statements it cannot prove.

The second incompleteness theorem says such a theory cannot prove its own
consistency (assuming it is consistent).

So even with perfectly precise axioms and rules, arithmetic truth outruns
derivability.

= Why these are connected

There are many routes between the two, but the core bridge is encoding syntax
and computation as arithmetic.

Once a theory can represent statements about programs and proofs:

- undecidable computational questions can be translated into unprovable
  arithmetic sentences, and
- proof-theoretic limitations can be reframed as decision problems that no
  algorithm solves.

For example, if a strong enough theory could decide every arithmetic truth, we
could often turn that into a decision procedure for problems equivalent to
halting, which is impossible.

So the same boundary appears in two languages:

- *algorithmic*: not everything is computable;
- *logical*: not everything true is provable.

= Takeaway

Computability and incompleteness are not niche paradoxes; they are structural
limits on formal reasoning itself.

They tell us that even perfect formalization leaves unavoidable blind spots:
some questions have no algorithmic solution, and some truths escape any fixed
axiomatic system.
