---
title: "License information"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

You may view the #link("https://github.com/youwen5/web")[source code of this site here].

Most markup content (primarily in Typst files) is
#link("https://creativecommons.org/licenses/by-sa/4.0/deed.en")[CC-BY-SA-4.0].
The rest (that is, everything not covered by the Creative Commons license),
including but not limited to logical code units, is
#link("https://www.gnu.org/licenses/gpl-3.0.en.html")[GPL 3] licensed unless
otherwise noted. This includes any Typst code that does not contain useful
content (i.e. prose), but rather is used for programming purposes.

In particular, the contents of (starting from the root directory) `src`,
`tests`, `web`, `typst`, and `nix` are all GPL licensed. Any Rust (`.rs`) files
and configuration files (`.toml`, `.lock`, etc) in general are GPL licensed.
Most content in `routes` is CC licensed, but you may e.g. copy Typst code that
generates HTML elements from there under the GPL as long as all actual content
(such as prose) is removed. All content in `public` is CC licensed unless
stated otherwise.
