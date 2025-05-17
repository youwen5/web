#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(title: "About")

#let chinese-name = html.elem("span", attrs: (lang: "zh-Hans"), [佑文])

How many words does it take to get to know a person? To start---I could tell you
my name is Youwen---romanized directly from the Chinese: #chinese-name.
I#(apostrophe)m from the San Francisco Bay Area but I currently study and live
in Santa Barbara, California.

I could tell you that I study math, and computers, but I also care at least as
much about music and philosophy and the human condition.

If it helps, we might saunter through the streets of IV or window shop in
downtown SB, and bemoan dining hall food or exorbitant prices in restaurants. I
could tell you about the subtle genius of _Disco Elysium_ or Rust#(apostrophe)s
algebraic type system. We could play _Risk of Rain 2_ or _Monster Hunter_, and
binge _Frieren_. Is that enough?

Or we could take an evening trek over by Campus Point, look out past the
crumbling bluffs, and admire the deep inky waters of the Pacific. We could
stare until the sun falls into a suffusion of gold and orange and indigo
and the rays tear the glistening waves asunder.

And then we would talk, about that out-of-tune carillon every Sunday, about
niche indie online science fiction, about suffering and capitalism, about art
and music and hope and death, and you could tell me about a million other
things.

And for a moment, we might forget the ennui of the world and feel weightless
atop its torrents.

And maybe we#(apostrophe)d finally get to know each other.

But until then---I hope the words here suffice.

#dinkus

= History

I#(apostrophe)m originally from Shanghai, China. I lived in the state of Utah
for a few years as a kid, before moving to the San Francisco Bay Area. I study
at UC Santa Barbara and spend most of my productive time doing math or
programming.

= Computing

I seek to create more _reliable_ and _resilient_ systems. To that end I
contribute to various open source projects that aim to increase reproducibility
and determinism in software systems at scale.

I run a purely functional (in the true mathematical sense) computing
environment that enables the deterministic deployment of software,
configuration, and infrastructure all the way down the stack. This includes
both the system itself, which can never mutate state and must be rebuilt for
modifications to be made, as well as a purely functional userspace, that keeps
programs configured precisely as described and managed transactionally. My text
editor is configured in a Lisp called Fennel and deployed in a purely
functional fashion by Nix.

Additionally, I prefer to work on and with software that respects my freedom.
In fact my M1 Macbook Pro runs an entirely free reverse engineered graphics and
driver stack. All of my computers run a free GNU/Linux operating system.

Key benefits of my approach to computing include:

- fearless hacking: as the system is rebuilt each time it is modified, it can
  simply transactionally rollback to a previous system generation.
- text-based and keyboard driven: by keeping the system entirely deterministic (not just
  technically, but philosophically), I can ditch unwieldy graphical interfaces
  and build a text-centered user experience.
- trustless full source bootstrap:
  secure yourself from malevolent state actors and resist the KTH by
  bootstrapping the entire system from its free source code and a minimal amount
  of binary seeds.

= Math

please help me man i can#(apostrophe)t even do an integral anymore all i know is abstraction

#webimg(
  "https://preview.redd.it/kwp14kysyul41.png?auto=webp&s=25544fd77159edfd1b6276ea2c59a4d6b5c9cfe3",
  "undergrad category theorist",
)
