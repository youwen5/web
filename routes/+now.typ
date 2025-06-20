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

I’m studying at #link("https://www.ucsb.edu/")[#smallcaps[ucsb]] until Spring
2026, when I will spend 2 quarters as a visiting student at Tsinghua University
in Beijing!

= Done and still doing

- Freshman year is over!

= Future

- I’m still thinking of starting a project called #quote[How #smallcaps[posix] can you get in 31 days?] where I try to write as much of a #smallcaps[posix] compliant operating system as possible, from scratch, with a 1 month time limit. Probably using Rust or Zig. I’m not sure how much time I’ll have for this during the summer, though.

= Fun

- Lately I’ve been playing/replaying #link("https://discoelysium.com/")[Disco Elysium].
- In lieu of Monster Hunter Wilds (which is impossible to run without a supercomputer), I’ve been playing Monster Hunter World and Iceborne instead.

= Prose

Some stuff I’ve been reading lately.

== Nonfiction

- #link("https://link.springer.com/book/10.1007/978-1-4612-0615-6")[Lectures on the Hyperreals] --- an introduction to nonstandard analysis
- #link("https://cdn.mises.org/Progress%20and%20Poverty_3.pdf")[Progress and Poverty] --- Henry George’s classic

== Fiction

- #link("https://archive.org/details/there-is-no-antimemetics-division/page/n9/mode/2up")[There is No Antimemetics Division] (also available as a #link("https://scp-wiki.wikidot.com/antimemetics-division-hub")[tale on the SCP wiki])
- #link("https://www.teamten.com/lawrence/writings/coding-machines/")[Coding Machines] --- a story based on the #link("https://wiki.c2.com/?TheKenThompsonHack")[Ken Thompson Hack]
