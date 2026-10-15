---
title: "What Computers Cannot Do"
description: "Website for course of the same name for Splash! at Berkeley 2026"
location: "Wheeler Hall 104, UC Berkeley"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

This is the homepage for #smallcaps[M1698: What computers cannot do], taught in
Fall 2026 at UC Berkeley's Splash program for high schoolers. If you are a
prospective student, please register on the
#link("https://berkeley.learningu.org/learn/splash.html")[Splash at Berkeley
  website.] The course is listed under Category: Math & Computer Science. The
class is taught by #link("/")[me.] I'm also teaching another class on
#link("../theorem-proving-in-lean/home")[theorem proving in Lean 4] on the same
day.

You can view #link("course-notes")[the course notes here] (under construction currently).


#callout[Catalog Description][
  We hear a lot these days about how powerful computers and AI are. They'll
  solve all your problems!

  Unfortunately, there are certain problems that computers will NEVER be able
  to solve, no matter how big, complex, or advanced!

  For example, the questions:

  "Will this app ever steal my data?" "Who will eventually win this game of
  Magic: The Gathering?" "Who is the most democratic winner of this election?"

  are all fundamentally unsolvable by computers. Also, did you know that our
  current computers are the most powerful we'll ever have (in theory)? Quantum
  computers do not increase computational power?

  This course will give a survey of interesting undecidable problems across
  computer science, which are problems that cannot be solved by any computer.
  We'll also talk about Turing-completeness, the Church-Turing Thesis, and
  other fundamental results about computability.

  The focus will be on intuition and understanding, so we won't get too bogged
  down in the technical details.
]

= Syllabus

The course is on *Sunday, November 15th, 3:10pm--5:00pm*, and intended for
high schoolers in 9th--12th grade. We'll learn some _computability theory_,
which is the very mathy theory behind _why_ computation works, why it's so
effective at solving all sorts of problems, and also the limitations of
the effectiveness of computation.

The expected background is someone who's fairly comfortable with abstract
mathematical reasoning, but the actual mathematical content of the course will
not be too great. In particular, we won't really need ideas from calculus or
even pre-calculus, just a familiarity with functions and algebra. I would rate
it at a 3/4 difficulty level, for a fairly strong high school math student.
Absolutely no programming experience is required. *You don't even need to know
how a computer works.* To quote the great Edsger Dijkstra:

#blockquote[
  Computer science is no more about computers than astronomy is about telescopes,
  biology is about microscopes or chemistry is about beakers and test tubes.
  Science is not about tools. It is about how we use them, and what we find out
  when we do.
]

We'll talk about what it means to be _effective_, how to define the concept of
"algorithm#footnote[And why this is way harder than it sounds! In fact, three
  legendary mathematicians;
  #link("https://en.wikipedia.org/wiki/Stephen_Cole_Kleene")[Stephen Kleene],
  #link("https://en.wikipedia.org/wiki/Alan_Turing")[Alan Turing], and
  #link("https://en.wikipedia.org/wiki/Kurt_G%C3%B6del")[Kurt Gödel]; all tried
  their hand at it, and it took decades to coalesce into a coherent notion.],"
why we can have one computer (like your laptop) that does basically every
computational task (something called _universality_), and why theoretical
computational power is limited.

We'll then digress into various discussions on _undecidable_ problems, which
are problems unsolvable by any notion of "computer," which can be formally
proven using computability theory. Examples include the famous _Halting
Problem_, and also deciding the result of Magic: The Gathering!

Because the theoretical weapons we wield to prove such results will take a few
weeks of a college level course (e.g. Math 136 at UC Berkeley), we won't try to
rigorously formulate and prove all of these results. Rather, the goal is to
give you a feel for how theoretical computer science is done and the
pathological results that fall out of it.
