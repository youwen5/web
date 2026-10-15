---
title: "Interactive theorem proving in Lean 4"
description: "Website for course of the same name for Splash! at Berkeley 2026"
location: "Wheeler Hall 100, UC Berkeley"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

This is the homepage for #smallcaps[M1697: Interactive theorem proving
  alongside computers in Lean 4], taught in Fall 2026 at UC Berkeley's Splash
program for high schoolers. If you are a prospective student, please register
on the #link("https://berkeley.learningu.org/learn/splash.html")[Splash at
  Berkeley website.] The course is listed under Category: Math & Computer
Science. The class is taught by #link("/")[me] and
#link("https://www.linkedin.com/in/nicholas-luo-b29504280/")[Nicholas.] I am
also teaching another #link("../what-computers-cannot-do/home")[class on
  computability theory] on the same day.

You can view #link("course-notes")[the course notes here] (under construction currently).


#callout[Catalog Description][
  In math, we make a lot of logical proofs, but who checks if they're correct?

  Historically, humans meticulously check proofs for logical gaps, in a painstaking verification process. Recent advances in theory and software have allowed us to instead develop proofs that can be checked rigorously by machines! This is called formal verification or formalization.

  For instance, for all numbers $x$, $y$, $z$, we know that $x+(y+z)=(x+y)+z$.
  This is the associative property of addition. But how do we know this is
  actually true for all numbers? What even is addition, anyways? We will learn
  how to build a theory of addition a computer can understand, then write a proof
  for the associative property of addition in a language that a computer can
  check, and formally verify its correctness. We'll also briefly touch on some
  recent breakthroughs in formal verification of much, much more complicated
  mathematical results, such as Fermat's Last Theorem, as well as why
  formalization is so important for AI + math!

  This course will introduce you to the world of machine-checked mathematics
  using the Lean programming language and interactive theorem prover. We'll talk
  briefly about how they work, a foundational theory of math known as Type
  Theory, and the profound equivalence between programming languages and
  mathematical proofs.

  If you're caught up with AI news, yes, that's the same Lean that OpenAI and
  Anthropic rely on to formalize their mathematical results!
]

= Syllabus

The course is on *Sunday, November 15th, 10:10am--12:00pm*, and intended for
high schoolers in 9th--12th grade. We'll learn about computer formalization of
mathematics, and in particular, work with a programming language designed to
formalize mathematical proofs called Lean. Such a system is known as an
_interactive theorem prover_.

The expected background is someone who's
dipped their toes into fairly abstract mathematical reasoning, but the actual
mathematical content of the course will be trivial, requiring nothing beyond
grade school arithmetic. I would rate it at a 2/4 difficulty level, provided
that the student is somewhat comfortable with logic and proof. Absolutely no
programming experience is required, as Lean is known as a _purely functional_
programming language, so experience in imperative languages like Java, C++,
Python, etc is not too helpful beyond imparting a basic familiarity with code
syntax and whatnot.

To learn Lean, we will be playing the
#link("https://adam.math.hhu.de/")[Natural Number Game], an online game where
the user tries to prove fundamental properties of the natural numbers and
operations like addition, multiplication, etc. This may seem trite, but the
nice part about it is that we don't have to think about any new or difficult
mathematics, and we can spend all our energy getting a hang of Lean.

We'll try to get as far in the game as possible, and I expect us to reach
around the boss level of Level 1 (Addition World). If time permits, we will
play as far as we'd like.

Additionally, at the start of the course, I'll briefly talk about the
background and theory behind Lean, something called _type theory_, and a really
cool result about mathematical proof and programming languages called the
#link("https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence")[Curry-Howard
  correspondence].

At the end of the course, I'll show off some real Lean code that verifies
actual nontrivial mathematics, and also some fun computer programs written in
Lean!

#btw[
  If any advanced Lean users show up who have already played the Natural Number
  Game, I have a separate set of far more difficult problemsets that will
  hopefully satiate their craving for formalization.
]
