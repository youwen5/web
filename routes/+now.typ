#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(day: 4, year: 2025, month: 9),
  title: "Now",
  location: "San Francisco, California",
  meta-description: "A now page, aka an answer to \"what have you been up to lately?\"",
  enable-comments: true,
)

This is my #link("https://nownownow.com/about")[now page], a (public) answer to
the question "what have you been up to lately?"

#blockquote(attribution: [--- #link(
    "https://en.wikiquote.org/wiki/Linus_Torvalds",
  )[Linus Torvalds]])[
  Do you pine for the nice days of minix-1.1, when men were men and wrote their own device drivers?
]

= Whereabouts

I'm studying at #link("https://www.ucsb.edu/")[#smallcaps[ucsb]] until at least
Winter 2026.

= Done and still doing

- I'm gonna be in Boston/Cambridge between Sep. 7th and 15th! Please reach out if you're nearby! I'm mostly going to be hanging around the MIT/Harvard area. I'll be a hacker at #link("https://hackmit.org/")[HackMIT] too!

= Future

- I'm still thinking of starting a project called "How #smallcaps[posix] can you get in 31 days?" where I try to write as much of a #smallcaps[posix] compliant operating system as possible, from scratch, with a 1 month time limit. Probably using Rust or Zig. I'm not sure how much time I'll have for this during the summer, though.
