---
title: How I do my computing
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

These are all the tools I use for hacking and tinkering on a daily basis, as of
the date above. By keeping an explicit list, I try to critically assess my
usage of any tool. The less reliant I am on software and computers, the better.

Due to numerous baseless attacks made by
#link("https://www.monadi.cc/computing")[interlocutors], I have decided to
further substantiate my philosophy about computing and technology. This may
come as quite a surprise to many who know me in real life and think I am some
computer-obsessed geek, but in general I am actually quite pessimistic about
personal computing technology and I think it is generally harmful (see: social
media, short form video apps, etc). I am much more excited about the
advancements computing can bring to research/industry than people's
personal lives. See footnote #footnote[In general,
  I feel that technology should be used overwhelmingly to eliminate meaningless
  _toil_, and to act as tools to augment or support thinking, _only when
  necessary and in no more than the necessary amount_.

  I don't support the prevalent notion amongst Silicon Valley technologists that
  everything which can be automated, should be automated. This is a vacuously
  true sentiment for the creation of art, of course, but I think it can also be
  applied to other areas as well.

  For example, when you plan your days out meticulously in a calendar program, it
  becomes easy to let the calendar fix your days and your activities instead. I
  don't mean of course that _anyone_ who uses a calendar has lost control of
  their lives to the machine, and if I had a much busier schedule I think I would
  probably use a calendar. The takeaway is that I try to think consciously weigh
  ceding a certain computing tool some control over an aspect of my life against
  the actual amount of time and toil saved.

  I find views like the following leveled against me quite incoherent:

  #blockquote[
    I find the majority of pages like this tend to engage in self-righteousness in
    avoiding fancy software and computing systems.

    #sym.dots

    I take the opposite view: that computation is a fundamental aspect of human existence, and serves to trivialize that which was previously nontrivial.
  ]

  I don't, per se, see any issue with the first complaint, and I don't see how
  the second has any bearing on my philosophy around computing at all.

  I certainly don't avoid "fancy software" or "computing systems." I maintain my
  own flavor of #link("https://functor.systems/functorOS")[Linux] (which happens
  to be used by the author of the above quote), and I've probably automated a
  greater portion of my life via computing than the vast majority of people on
  Earth.

  My primary concern is best captured by the notion of "tool-shaped objects."
  These are programs that _feel_ like great tools, and _feel_ like they're
  multiplying your productivity, but in reality don't really do much of
  anything. These include things like Vim, Notion, and many LLM-based learning
  applications. (Disclaimer: I use Neovim myself, so trust that I don't mean
  these programs are uniformly useless, but rather that they are often used in
  wasteful ways. My philosophy about LLMs actually leads me to conclude that
  they are bad in a _fundamental sense_, i.e. independent of their actual
  capability or "usefulness," but I will not discuss that controversial view
  here.)

  Of course, all such programs _can_ be great tools, but you know the guy/gal I'm
  talking about. Whether it's ricing out Vim until it resembles an ersatz VS
  Code, or meticulously documenting every aspect of their life in
  Notion/Obsidian, the common result is _not much more work gets done_.
  Obsessively using Notion as a second brain or optimizing massive LLM workflows
  (see: OpenClaw) _feels_ like it's computing being a "fundamental aspect of
  human existence" or "trivializing that which was previously nontrivial," but
  it's just LARPing productivity.

  This famous quote by Socrates about the invention of writing has been brought
  up even by prominent thinkers like
  #link("https://mathstodon.xyz/@tao/114179220511702041")[Terence Tao].

  #blockquote[
    For this invention will produce forgetfulness in the minds of those who learn
    to use it, because they will not practice their memory. Their trust in
    writing, produced by external characters which are no part of themselves,
    will discourage the use of their own memory within them. You have invented an
    elixir not of memory, but of reminding...
  ]

  It is sometimes used by the pro-AI camp to rebuke detractors of LLM
  technologies who claim that reliance will atrophy the critical thinking skills
  of the user.

  But I think, if we look past the initial ridicule, there is some element of
  truth here. Of course, writing _is_ one of the most important inventions in the
  history of civilization, but it is _also_ true that those who obsessively
  record everything will likely degrade their memory. It's quite obvious,
  however, that the benefits of writing far outweigh the detriment. I only ask
  that we stop and think about whether the benefits of all this computing
  technology we seek to integrate into our lives _actually_ outweigh the
  downsides.
]

= Overview

You can click the hyperlinked rows for more details where applicable.

*Core:*

#table(
  columns: 2,
  [#link(<operating-system>)[OS]], [functorOS (based on NixOS unstable)],
  [Editor], [Neovim],
  [Browser], [Firefox],
  [Kernel(s)], [linux-zen, linux-asahi],
  [Desktop], [Hyprland (Wayland)],
  [Layout], [hyprscrolling],
  [Terminal], [kitty],
  [Login shell], [Nushell (w/ fish completer)],
)

*Productivity:*

#table(
  columns: 2,
  [Typesetting], [Typst],
  [Accounting], [#link("https://hledger.org/")[hledger]],
  [Audio Workstation], [#link("https://www.reaper.fm/")[Reaper]],
  [#link(<photography>)[Photography]],
  [#link("https://www.darktable.org/")[Darktable], #link("https://www.digikam.org/")[digiKam]],
)

= Computers

#table(
  columns: 2,
  table.header([Hostname], [Specs]),
  [`adrastea`], [Blade 14, Ryzen 9 5900HX, RTX 3070 Max-Q, 16GB DDR4],
  [`demeter`], [Custom desktop, i7-13700KF, RTX 4080 FE, 32GB DDR5],
  [`callisto`], [Macbook Pro, Apple Silicon (M1 Pro), 16GB unified memory],
  [`gallium`], [2014 Mac Mini, used as a homelab and server],
)

= Other devices

#table(
  columns: 2,
  [E-reader], [Boox Note 5C],
  [Audio interface],
  [#link(
    "https://us.focusrite.com/products/scarlett-4i4-3rd-gen",
  )[Scarlett 4i4 (Gen 3)]],

  [Microphone],
  [#link(
    "https://www.astonmics.com/EN/product/Mics/Origin?ref=theboothambassadors.com",
  )[Aston Microphones Origin]],

  [Headphones],
  [#link(
    "https://www.sennheiser-hearing.com/en-US/p/hd-600/",
  )[Sennheiser HD600]],

  [#link(<photography>)[Camera]],
  [#link(
    "https://electronics.sony.com/imaging/interchangeable-lens-cameras/all-interchangeable-lens-cameras/p/ilce7cm2b",
  )[Sony #(sym.alpha)7Cii]],

  [#link(<photography>)[Lenses]],
  [#link("https://electronics.sony.com/imaging/lenses/full-frame-e-mount/p/sel35f28z")[Carl Zeiss / Sony 35mm F/2.8], #link("https://www.sigmaphoto.com/24-70mm-f2-8-dg-dn-ii-a")[Sigma Art 24-70mm DG DN II]],
)

= Keyboards

#table(
  columns: 2,
  [#link(
    "https://www.keychron.com/products/keychron-q60-max-qmk-via-wireless-custom-mechanical-keyboard",
  )[Keychron Q60 Max]],
  [Happy Hacking layout, Gateron Oil Kings (factory lube)],

  [Custom tofu65], [Ink Black v2 (hand lube)],
)

= Operating system <operating-system>

On all of my machines (including Apple), I currently run
#link("https://functor.systems/functorOS")[functorOS], a custom spin-off of
#link("https://nixos.org/")[NixOS unstable], the
bleeding-edge rolling-release branch of NixOS.

On Apple Silicon, I rely on the Asahi Linux project which provides the
reverse-engineered graphics stack and hardware abstractions required to run
Linux.

#btw[
  NixOS is a highly idiosyncratic Linux distribution ("distro") that behaves entirely
  differently from nearly all other distros. Your entire system is specified
  through expressions written in the Nix programming language---you must write
  code that specifies exactly how your system is deployed. For example, if I
  want to update the colorscheme of my system---it is not possible to open any
  sort of settings menu and click a button to do so---rather, I must enter my
  configuration and figure out the requisite Nix code to write in order to set
  the color.

  You may say "this sounds completely insane." You would be correct.
  However, somehow, _it works_. Just one consequential advantage of the
  aforementioned tedium is my entire system's colorscheme is now generated at
  build-time, by running a genetic algorithm on my wallpaper that literally
  _simulates darwinian natural selection_ to evolve the optimal colorscheme to
  pair with it. Because all programs are also configured in this manner, the
  colorscheme can set not only typical system themable programs, but also
  inject colorschemes into any program managed by NixOS (for me, that would be
  all of them), such as Discord, Spotify, and more.
]

Additionally, I keep a darwin (macOS) and Windows 11 installation around for
when I need them. Windows is used for crappy video games with invasive
anticheats that don't run on Linux (and I wouldn't
install them there anyways)---not limited to Valorant, Destiny 2, LoL, etc. I
rarely play these games anymore so likewise my Windows installation sees uptime
every couple months at most. Linux can run nearly every other Windows game
through #link("https://www.protondb.com/")[Proton]. macOS is seldom used but
usually handles multimedia better---e.g. if I need to plug into a projector to
play a movie or presentation.

= Editor

I use #link("https://neovim.io/")[Neovim]. Before that---VS Code---but I was
growing increasingly wary of the AI
#link("https://en.wikipedia.org/wiki/Enshittification")[enshittification] being
integrated into the editor, as well as a general growing distaste for electron.

I created my #link("https://github.com/youwen5/viminal2")[configuration from
  scratch.] I use quite a few plugins, but I try to stick to plugins that
strictly extend the capabilities of existing features rather than add entirely
new ones.

= Browser

I use #link("https://zen-browser.app/")[Zen], a fork of Firefox. It's kind of
janky but it's the only browser with all the features I want---namely, not
Chromium based and supports sidebar tabs. I maintain the semi-popular
#link("https://github.com/youwen5/zen-browser-flake")[Nix package] for it.

= Kernel

I use `linux-zen` in general because regular `linux` has some weird
interactions with my laptops when returning from suspend. I keep
`PREEMPT_DYNAMIC` enabled for realtime capabilities.

On my Apple Silicon devices I of course use the `linux-asahi` kernel from the
#link("https://asahilinux.org/")[Asahi Linux] project. But I still use NixOS,
not the Asahi Fedora Remix. If you're curious, it is a surprisingly smooth
experience.

= Desktop environment

I use #link("http://hyprland.org")[Hyprland]. It has all the features I expect
out of a window manager. I use a plugin that enables a scrolling layout like
PaperWM. However, the codebase is pretty messy and I frequently experience
minor regressions and the community is somewhat suspect.


Therefore, I'm looking to jump ship to the dedicated scrolling compositor
#link("https://github.com/YaLTeR/niri")[Niri] once a few features are added.

= Terminal

#link("https://sw.kovidgoyal.net/kitty/")[kitty] is good and Kovid is a cool
guy. The terminal does everything I want and more, it's fast, and I've never
experienced any bug. No complaints.

= Login shell

I used to use `fish`, but now I'm on #link("https://www.nushell.sh/")[nushell],
an experimental shell that takes the concept of #smallcaps(all: true)[UNIX] pipes and makes them pass
typed structured data that is much easier to manipulate.

= Computers

`adrastea` is a laptop-turned-workstation, on account of poor Razer quality
control forcing me to toss the battery out. `callisto` is my daily driver
laptop---the Apple Silicon processor gives it great battery life. `demeter` is
my home PC, which I don't keep with me in college.

= Photography <photography>

I recently got into taking pictures. I like shooting street, mostly. When I
have time I'm planning to integrate a gallery and zines into this website.

I originally shot out of a Nikon D7200 (spoils of war from an MIT hackathon),
but I since upgraded to a Sony #(sym.alpha)7 series camera. I edit my RAWs in
Darktable. It's free software and wonderful to use. I have this massive Sigma
zoom lens right now but I just ordered the Zeiss 35mm f/2.8, a really compact
Sony e-mount prime lens that supposedly has the "Zeiss effect."
