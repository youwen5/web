#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(day: 25, year: 2025, month: 5),
  title: "Now",
  location: "Santa Barbara, California",
  meta-description: "A now page, aka an answer to \"what have you been up to lately?\"",
  enable-comments: true,
)

This is my #link("https://nownownow.com/about")[now page]. A now page is a
detailed answer to the question #quote[what have you been up to lately?]

#webimg(
  "https://raw.githubusercontent.com/youwen5/youwen5/refs/heads/main/profile-3d-contrib/profile-night-rainbow.svg",
  "github contrib graph dark",
  caption: [
    More charts like the above #link("/charts")[here]
  ],
  extraFigureClass: "hidden dark:block",
)

#webimg(
  "https://raw.githubusercontent.com/youwen5/youwen5/refs/heads/main/profile-3d-contrib/profile-season.svg",
  "github contrib graph light",
  caption: [
    More charts like the above #link("/charts")[here]
  ],
  extraFigureClass: "dark:hidden",
)

= Whereabouts

I'm studying at #link("https://www.ucsb.edu/")[#smallcaps[ucsb]] for the foreseeable future.

= Done and still doing

- Recently I decided to switch to pure math, from applied math. I think the coding and numerical methods in applied math are not that interesting.
- In a somewhat dissonant move I also picked up a double major in computer science, mainly to study #smallcaps[programming languages] and #smallcaps[formal verification], among other things. I am not particularly interested in software engineering as a career, however. Most commercial software built by companies these days is, as Linus Torvalds would say, #quote[#link("https://www.phoronix.com/news/MTc1MDQ")[utter crap.]] But I am open to writing commercial software if and when it would benefit the public good.

= Future

- I'm thinking of starting a project called #quote[How #smallcaps[posix] can you get in 31 days?] where I try to write as much of a #smallcaps[posix] compliant operating system as possible, from scratch, with a 1 month time limit. Probably using Rust or Zig. I'm fleshing the idea out right now.

= Fun

- Lately I've been playing/replaying #link("https://discoelysium.com/")[Disco Elysium].
- In lieu of Monster Hunter Wilds (which is impossible to run without a supercomputer), I've been playing Monster Hunter World and Iceborne instead.

= Prose

Some stuff I've been reading lately.

== Nonfiction

- #link("https://link.springer.com/book/10.1007/978-1-4612-0615-6")[Lectures on the Hyperreals] --- an introduction to nonstandard analysis
- #link("https://cdn.mises.org/Progress%20and%20Poverty_3.pdf")[Progress and Poverty] --- Henry George's classic

== Fiction

- #link("https://archive.org/details/there-is-no-antimemetics-division/page/n9/mode/2up")[There is No Antimemetics Division] (also available as a #link("https://scp-wiki.wikidot.com/antimemetics-division-hub")[tale on the SCP wiki])
- #link("https://www.teamten.com/lawrence/writings/coding-machines/")[Coding Machines] --- a story based on the #link("https://wiki.c2.com/?TheKenThompsonHack")[Ken Thompson Hack]
