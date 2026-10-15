---
title: "Course Notes for TPIL"
published: 2025-10-15
description: "Course notes on theorem proving in Lean for Splash! at Berkeley 2026"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

These are the notes for homepage for #smallcaps[M1697: Interactive theorem
  proving alongside computers in Lean 4], taught in Fall 2026 at UC Berkeley's
Splash program for high schoolers. If you are a prospective student, please
instead check the #link("home")[course homepage.]

= Notions

Proofs are fundamentally about *propositions*, and their *truth values*. A
proposition is basically a statement that could be either true or false.

#example[
  - $2 + 2 = 4$
  - I woke up this morning
]

#example[
  - $1 + 1 = 3$
  - The earth is flat
]

#example[
  - $1 + 1$
  - $integral e^(-x^2) dif x$
  - Is it going to rain today?
]

There is a proposition called $top$ which is always true.

We can compose propositions using certain logical rules. For propositions $P$ and $Q$,

- Conjunction: $P and Q$ is true only if both $P$ and $Q$ are both true. This is the logical AND.
- Disjunction: $P or Q$ is true only if at least one of $P$ or $Q$ is true. This is the logical OR.
- Negation: $not P$ is true only if $P$ is false. This is the logical NOT.
- Implication: If $P -> Q$ is true, and $P$ is true, then $Q$ is true. This is a rule called _modus ponens_ and is somewhat unintuitive.

How do we decide whether
