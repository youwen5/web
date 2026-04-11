---
title: "From Computability to (In)completeness"
published: 2026-03-26
description: "Proving Gödel's incompleteness theorems via theoretical computer science"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#let godel = [Gödel]
#let definition = body => callout("Definition", body)
#let lemma = body => callout("Lemma", body)

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

If you like math, you probably know the Incompleteness Theorems of Kurt Gödel,
which state that

1. A (sufficiently expressive) mathematical system cannot be both _consistent_ and _complete_, and
2. A (sufficiently expressive) mathematical system that is consistent cannot prove its own consistency.

By _sufficiently expressive_, we just mean a system at least powerful enough to
encode the elementary arithmetic of natural numbers, i.e. multiplication and
addition in $NN = {0, 1, 2, 3, ...}$.

By _consistent_, we mean that the system does not equate all statements. That
is, we cannot prove that $"True" = "False"$. An inconsistent system where all
statements are true and false simultaneously is rather useless for the working
mathematician.

By _complete_, we mean that every true statement in the system actually has a
proof (of its truth). Gödel's first incompleteness theorem says that a
consistent (i.e. useful) system for doing mathematics _cannot_ be complete---it
is guaranteed to have true statements that cannot be proven within the system!
Moreover, the second theorem says that one such statement which cannot be
proven is that _the system itself is consistent!_ So if we come up with a good
mathematical system, even one that seems to be consistent, we can't prove for
sure that it is indeed consistent! To address the elephant, this is in fact
true of the current mainstream system for mathematics, called $cal(Z F C)$, and
every other alternative system, like type theory. There is no solution for this
"fatal flaw" of mathematics.

Well, this is all kind of insane and existential dread-inducing, to say the
very least, and hence these results have been widely discussed lately in "pop
math" circles, like this video by the pop-science channel Veritasium:
#smallcaps(link("https://www.youtube.com/watch?v=HeQX2HjkcNo")[Math's Fatal
  Flaw.])

#btw[
  To avoid scaring people away too early, I'm using the
  colloquial term "mathematical system" here to mean a set of logical _axioms_
  upon which we can form propositions.

  Actually, more precisely, I mean a full proof system. Many exist, including
  Hilbert-style, natural deduction, sequent calculus, etc. These consist of a
  set of axioms and _deduction rules_.
]

The standard proof presented in these expositions hinges on something called
#godel numbering. This technique lets us prove the incompleteness theorems
without introducing too much extra machinery outside of pure logic, which is
useful to keep things digestible.

But what if we like machinery? Specifically, computing machinery. Anyone with an
interest in computer science has likely heard of the _Turing machine_---a
incredibly simple model of computation that consists of a single tape with
symbols and a single, fixed tape head that reads or writes on the tape one
symbol at a time and shifts it left or right.

It turns out that this simplistic caricature of computing is _the most powerful
theoretical model of computation_ we have, and it is powerful enough to
expressive _any_ algorithm a typical modern "computer" can perform. (From a
certain point of view, the Turing machine may be viewed as the _definition_ of
computation itself. This observation is the heart of the
#link("https://en.wikipedia.org/wiki/Church%E2%80%93Turing_thesis")[Church-Turing
  thesis].)

Computation and mathematics are fundamentally, inextricably linked. And there
is no better way to demonstrate this than to construct a proof of both of
#godel's theorems, which express fundamental limitations of mathematics itself,
via Turing machines and advanced, fundamental results about computation like
decidability and recursion.

We'll start with a working overview of Turing machines, and construct a Turing
Machine to search for mathematical proofs. Then, we embark on a brief excursion
into self-replication to prove Kleene's Recursion Theorem, which we'll use
together with our proof-searching machine to prove the incompleteness theorems.

#outline()

= Crash course on Turing machines

I've already given a description of a Turing machine (TM), and it really is
that simple. One tape. One tape head that reads a single cell from the tape at
a time. The only operations are to read the current cell under the tape head,
rewrite the current cell under the tape head, or move left/right by a single
cell. The symbols written in the tape are constructed from a finite set of
possible symbols called the _alphabet_, and are entirely arbitrary. Lastly, the
machine has a set of internal states, which helps determine its behavior. Each
time the machine moves, it can also change its internal state. These states are
also entirely arbitrary. The total description of the current state of a Turing
machine, including its internal state, the symbols on the tape, and the
position of the head, is called a _configuration_.

Technically, the tape is also infinitely long, but the actual _input_ to the
machine must be finite (that is, the initial sequence of symbols we start the
machine with). In our theoretical model, the tape simply stretches infinitely
left and right with empty or "blank" cells. The reason for this is to give the
tape an "infinite memory," essentially equivalent to giving a modern computer
an unlimited amount of RAM. This is important as many problems' memory usage
scales unbounded with the size of the input, and a finite memory machine would
not be general enough to solve all instances of such problems (we could always
devise an finite input requiring memory larger than the machine's).

Formally, a TM is defined as a 7-tuple that captures all the information about
it (an $n$-tuple is just an ordered list of $n$ elements). It's extremely
important, however, not to get bogged down in the mathematical formalism, and
you should be able to grasp the rest of the ideas without it. I'll state the
formal definition for posterity.

#definition[
  A Turing machine is a 7-tuple $M = chevron.l Q, Gamma, b, Sigma, delta, q_0, F
  chevron.r$, where

  - $Gamma$ is a finite and nonempty set of symbols that can appear on the tape
    called the _alphabet_.
  - $b in Gamma$ is the _blank symbol_. This is the aforementioned blank that
    is appears infinitely in both directions, and is the only symbol allowed to
    do so.
  - $Sigma subset.eq Gamma without {b}$ are the tape _input symbols_, which are
    allowed to appear in the initial tape contents, aka the input.
  - $Q$ is a finite, nonempty set of machine _states_.
  - $q_0 in Q$ is the initial machine state.
  - $F subset.eq Q$ is the set of _accepting states_. We say an input is
    _accepted_ by the machine $M$ if $M$ eventually halts in a state in $F$.
  - $delta : (Q without F) times Gamma harpoon Q times Gamma times {L, R}$ is a
    partial _transition function_. Here $L$ and $R$ represent left and right
    shift. If the machine ends up in a configuration that is not covered by
    $delta$, then the machine halts.
]

To be clear, this definition, even according to the original authors, is *not
actually that useful* and only really exists for mathematical precision, so
don't worry if you couldn't wrap your head entirely around it. It's far more
important to understand intuitively what we allow or restrict our Turing
machine to do. When we describe TMs, for instance, we usually give an informal
description of what they do rather than the actual formal definition.

The transition function $delta$  is probably the least intuitive part of the
definition, but it is really the fundamental portion that describes its logic.
You can think of it as taking into account the current machine state and
looking at the current symbol under the tape head, then deciding the next
machine state, a new symbol to write in the current cell, and whether to move
left or right. If we end up in a machine configuration not accounted for, then
halt.

Again, the formal definition is not too important. It simply makes
mathematically rigorous the abilities and notions of the machine, namely, a
finite alphabet, a finite input, a finite set of internal states, an infinite
memory, and a specification for what the machine should do whenever it sees a
given symbol based on its internal state.

== Examples

idk come up with some demonstrative examples of turing machines lol, maybe like an example of two machines that pass control to each other

== Digression: universality and the Church-Turing Thesis

One may begin to wonder why

== Digression: binary encodings

all computable real numbers, common data structures, _code itself_ can be represented as binary strings

= The proof-searching machine and Hilbert's Entscheidungsproblem

introduce a machine that searches for proofs and the decision problem

= Undecidability and computability

As seen in the Entscheidungsproblem (Decision Problem), decidability is a
fundamental concept in computation.

= Self-replication and Kleene's Recursion Theorem

Can we write a program that prints its own source code? At first glance, I
would probably say no. A car factory is more complex than a car, because it
must contain all the information of a car as well as the instructions for how
to construct one! A program that prints itself seems like it should be
impossible, since it needs all the information of the program to be printed
(its own source code), as well as the additional instructions for how to print
it! How could a program even obtain access to its own source code?

Such a program is known as a _quine_, and it is not only possible to write
quines, but it's _guaranteed_ to exist in every single Turing-complete
language.

But first, why do we care? The construction of a quine is closely related to
the fact that every Turing machine is able to obtain a copy of its own
description, and then _go on to compute with it_. That is, in the description
of a TM $M$, we can include the instruction "obtain $chevron.l M chevron.r$" as a
step. This is an advanced result in the theory of computability known as the
Recursion Theorem, and it was first formulated by Stephen Kleene, a fellow
student of Alan Turing under Alonso Church.

== The Turing machine SELF

We describe the self-replicating Turing machine $"SELF"$. The idea is to
construct the machine as two sub-machines, where the first prints the
description of the second. When the second machine runs, on its input tape is
its own description, and it can easily obtain the description of the first
machine---just find the description of a machine that prints the description of
the second machine. Now the second machine has both the description of itself
and the first machine, and it can simply erase the tape and print both to
complete the program.

This motivates the following lemma.

#lemma[
  For any string $s$, it's always possible to obtain the description of a TM
  that prints $s$ and halts.

  More precisely, there exists a _computable_ function $q : Sigma^* -> Sigma^*$
  that for any string $s$, $q(s)$ is the description of a TM $P_s$ that prints
  $s$ and halts.
]

#proof[
  Let the TM $Q$ be defined by: on input $s$,
  1. Construct the Turing machine $P_s$:
    1. Erase input.
    2. Print $s$ on the tape.
    3. Halt.
  2. Output $chevron.l P_s chevron.r$.
]

Now we can more precisely describe the machine $"SELF"$.

Let $A$ and $B$ be the two subprocesses of $"SELF"$. $A$ is a machine that
writes out the description of $B$, denoted $chevron.l B chevron.r$ and halts.
After $A$ finishes, it passes control to the machine $B$, which reads
$chevron.l B chevron.r$ from the tape and obtains $chevron.l A chevron.r =
q(chevron.l B chevron.r)$. Now $B$ can simply write out $chevron.l A B
chevron.r$, which is $chevron.l "SELF" chevron.r$!

// This algorithm is easy to implement in a real programming language, e.g.
// JavaScript. Note that for the Turing machine, it both outputs and reads data
// from the same place, but in JavaScript we'll store the description of part $B$
// in a variable and print the end result to the console.
//
// ```javascript
// console.log()
// ```


== The Recursion Theorem



= At last, the Incompleteness Theorems

