---
title: How I do my computing
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

These are all the tools I use for hacking and tinkering on a daily basis, as of
the date above. By keeping an explicit list, I try to critically assess my
usage of any tool. The less reliant I am on software and computers, the better #footnote[
  For example, I explicitly choose not to use a calendar program, except to set reminders for
  extremely important events. Meticulously organizing your life with a Google
  Calendar---you're literally ceding control to the machine.
].

= Overview

*Core:*

#table(
  columns: 2,
  [OS], [NixOS (unstable, "Xantusia")],
  [Editor], [Neovim],
  [Browser], [Zen],
  [Kernel(s)], [linux-zen, linux-asahi],
  [Desktop], [Hyprland (Wayland)],
  [Layout], [hyprscroller],
  [Terminal], [kitty],
  [Login shell], [Nushell (w/ fish completer)],
)

*Productivity:*

#table(
  columns: 2,
  [Browser], [Zen],
  [Typesetting], [Typst],
  [Accounting], [#link("https://hledger.org/")[hledger]],
  [Audio Workstation], [#link("https://www.reaper.fm/")[Reaper]],
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
  [E-reader], [Kindle Scribe],
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

= Operating system

On all of my machines (including Apple), I currently run
#link("https://nixos.org/")[NixOS unstable] (NixOS 25.11 "Xantusia"), the
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
