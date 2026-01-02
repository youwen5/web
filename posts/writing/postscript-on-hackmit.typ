---
title: "Postscript on HackMIT"
published: 2025-09-22
author: "Warren Futaba Lex, Ananth Venkatesh, and Youwen Wu"
location: "Massachvsetts Institvte of Technology, Cambridge, MA"
---

// date: datetime(day: 22, year: 2025, month: 9),
// location: "Massachvsetts Institvte of Technology, Cambridge, MA",
// enable-comments: true,
// subtitle: "An editorialized retrospective on HackMIT presented as an epic tale of wits and grit, contributed partly by guest writer Warren Futaba Lex. This essay is written from his perspective.",
// special-author: "Warren Futaba Lex, Ananth Venkatesh, and Youwen Wu",

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#dropcap[
  In 2025, I became likely the only student in high school---and also probably
  the youngest person---to win HackMIT in its twelve year history. Here, I detail
  my successful attempt to "hack" HackMIT and my contributions to the hackathon.
]

I initially applied to HackMIT over the summer of 2025. I noted my experience
in electrical engineering, but approached the application as a purely
intellectual and philosophical exercise. I mostly detailed my fascination with
the spirit of creativity and ingenuity embedded into the fabric of MIT and
HackMIT in particular. I noted my careful study of the stories of Sam
Bankman-Fried and other inventors, and how I sought to use the hackathon as an
opportunity to contribute to Taiwanese--Azerbaijani technologies, a pseudonym
for the dual-use technology industry and related megacorporations. Despite the
numerous controversial and contentious opinions expressed in my application, it
must have been favored by the HackMIT organizing committee, since I was
immediately accepted as part of the early decision round. Two of my future
teammates, students at MIT, were waitlisted and ultimately rejected, though
were allowed to participate through a loophole in the HackMIT regulations.
Whether I entered HackMIT by divine providence or a purely meritocratic process
I shall never know, but I was determined to bring my ingenuity to bear on the
world's most pressing challenges for the hackathon.

#dinkus

Over the summer, I joined a loosely-associated intellectual collective known as
functor.systems, a homotopy-coherent collective of free software hackers. Three
other members of this organization, namely Youwen, Ananth, and a hitherto
unknown quaternary interlocutor, decided to participate in the hackathon, and I
decided to join them in an epic collaboration. I flew in to the MIT campus a
few days prior to its start date to preview the full gamut of intellectual
exercises on campus. After sitting through lectures in real analysis, fourier
transforms, digital circuits, and political economy, I proceeded to synthesize
my newfound knowledge into a guiding vision for my team.

Immediately taking my theoretical political economy lessons and putting them to
work (_mens et manus_), I decided to take a radical approach to hackathon labor
allocation. Typical and primitive hackathon teams will decide on a singular
project idea and commit the synchronized efforts of all four members towards
the final product. I immediately identified this as a high point of
inefficiency. At this key instant, our team's triumphant fate was already
sealed---it remained only a matter of implementing my machinations.

Let me make a metaphor. Typical teams where all 4 members work on the same
project are executing as asynchronous processes in a language such as
JavaScript. They depend on each other's state, namely, the current progress
they've made. They may be forced to block until the requisite tasks are
completed by each other. This drastically reduces efficiency.

In our team, I decided to apply my lessons from political economy and structure
our labor such that we operated at the utility-maximizing Pareto frontier. I
developed three independent research "thrusts" for our team to focus on. First,
Ananth was assigned to theoretical research and development to make full use of
his training in the Zardini Lab developing abstractly nonsensical methods for
engineering challenges as well as proficiency in Haskell. Second, Youwen was
assigned to work on an experimental 3D user interface based on UV mapping as
well as research the feasibility of deploying a swarm of artificial
intelligence agents. The final research thrust was mine, and it was hardware
development and deployment.

In the previous process metaphor, rather than an asynchronous yet blocking set
of processes a la JavaScript, we became fully concurrent and purely functional
Haskellian processes. Rather than being forced to block on each other's state,
each innovator was free to rapidly deploy experimental designs at breakneck
speeds without regard for each other. By giving each member autonomy over
research and development, we could emulate the innovative environment of a
research university, far more powerful than the corporatist structure of a
traditional hackathon team.

As an electrical engineer, incorporating my talents into a mostly
software-based project was exceedingly difficult---however, from my extensive
literature review, I discovered that there were critical innovations lacking in
the augmented reality (AR) space, while the AI agents space was oversaturated
with corporate slop. I proceeded to focus my attention on reverse engineering
the hardware protocol for a pair of AR glasses that I managed to procure from
corporate sponsors. After a few hours of hacking, I established a direct
firmware interface with the device and was able to control it flawlessly over a
local network. The amount of time it took to set this up was highly nontrivial,
and completing a project of this scale under the time constraints was highly
restrictive.

Nevertheless, I was able to apply mathematical abstractions to further simplify
my tasks and work through the numerous challenges I encountered. With some
insight from my teammates and my attendance in a single lecture of an abstract
algebra course while on campus, I used the permutation group to create a
structured method for debugging the firmware interface. After consulting with
our team's resident category theorist, I developed a novel category--theoretic
monadic interface to ensure fault-tolerant communication with the glasses,
which allowed a provably optimal deployment of AR directions for maps, which
formed the first of three major components in our project.

At this time you may wonder what happened to our 4th unknown interlocutor.
Where was his research thrust? Simply put, I had immediately identified him as
well to be a suitable yappatron (as he was a double major in the MIT Sloan
School of Management), so I sent him to bed early in order to recover full
energy for our presentations the following day. This, too, was simply part of
the Pareto frontier.

Following a grueling 20-hour hackfest in a Hayden Library study room, we had
made vast amounts of progress on each of our research thrusts. Firstly, as I
mentioned, I had completed the deployment of AR glasses. This involved the
deployment of our own servers within the MIT intranet. I had to procure an MIT
domain from MIT IS&T to facilitate the glasses' operation (side note: did you
know it was that easy to get an official MIT subdomain? visit
#link("https://functor.mit.edu")[functor.mit.edu]).

Second, Ananth had made substantial progress on his theoretical research. He
had developed a novel algorithm based on stochastic gradient descent in raw
Haskell that would compute a mapping from a 2 dimensional geographic map to an
$n$-dimensional surface where the metric distance corresponded to an arbitrary
metric. For example, we could compute a "travel-time map" in 3 dimensions (so
that humans can interpret it) and warp a 2D map into a 3D version such that the
distance between points on the map represents the amount of time it takes to
walk/public transit/drive between them rather than physical distance.

There was only a slight problem with Ananth's project: the code had never
actually been ran in the 19 hours prior, as he had been far too busy furiously
hacking away. Upon running the code in the 20th hour, all Haskellian safeguard
broke down and the code began to spew unintelligible and mangled data. Ananth
began despairing and declaring doom for our team. He even suggested the
ridiculous idea of "going to bed."

Unacceptable. Were we about to back down at the last moment? We stood at the
precipice of greatness---we were this close to the summit. I had already
sacrificed so much (2 days worth of SRVHS classes) to be here in Cambridge. MY
NAME IS WARREN "KAITOTLEX" KAITO FUTABA T. LAWRENCE LEX LIN AND I WOULD NOT
TAKE ANYTHING LESS THAN FULL AND UNABATED VICTORY. I WOULD REND THE CODE
ASUNDER AND FORGE IT BACK TOGETHER INTO A BEAUTIFUL SYMPHONY OF TYPES AND
LAMBDAS.

In any case, my division of labor approach was instrumental in our final hour.
With just a couple hours left to judging, we had to quickly pivot away from
Ananth's research towards a system that actually worked: Youwen's swarm of AI
agents. While I had been hacking away on the AR glasses and Ananth had been
fruitlessly wrangling Haskell types, Youwen had successfully completed the
deployment of multiple AI agents that would traverse the streets of Cambridge
and go sailing in the Charles. This was essentially our side project in case
the main one went awry.

With no choice, I began the integration of our independent research operations.
This was the true genius of my plan. At the end, all of our independent
research would be synthesized into the one true project that would be even
greater than the sum of its parts. I retrofitted my AR glasses to display the
thoughts of the AI agents so that you could view the status and thoughts of the
agents at all times. We then scrapped Ananth's project for parts and
jerry-rigged it to integrate loosely with the agents to feed the high
dimensional embeddings of various metrics into the agents to further embody
them. With this, we had finally created our end project: a fully autonomous
swarm of AI agents that would rely on our novel space-time embedding system to
traverse the world and feed data back to the user in their AR glasses as they
walked around.

This final product was far too advanced, despite it being simply our side
project. That is, this final project we submitted was simply a random throwaway
program that our functor.systems hackathon team created in parallel while the
main project was being developed. Our operation at the Pareto frontier was just
too powerful such that even our side project still easily cleared out every
single other project. Our mysterious fourth teammate returned from his slumber
to present our work and after a few rounds of judging we were declared
victorious, winning the Grand Prize and highest honor in the entire event. I
officially became the first high schooler in (known) history to ever walk away
with a HackMIT grand prize, one of, if not the most prestigious awards in
collegiate hacking. Warren "Futaba" Lex, signing off.
