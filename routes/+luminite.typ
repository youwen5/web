#import "./lib/html-shim.typ": html-shim

#show: html-shim.with(title: "Luminite")

#let done = emoji.checkmark.box
#let todo = sym.ballot
#let in-progress = emoji.clock

This is a system for building a static site generator using Typst as the
primary way of setting content. This page is my todo-board where I plan out and
track feature implementation. The source code is available on
#link("https://github.com/youwen5/luminite")[GitHub].

Big picture next steps: get metadata working, and generate some more advanced
pages that rely on introspecting the system at build time.

== Started

- #in-progress Set up a templating system that can embed the HTML (see #link("https://github.com/vidhanio/hypertext")[hypertext]).
  - #in-progress Introspection on the site at build time.
  - #todo Integrate metadata system into templating system.
  - #todo Component system so site can share common header, footer, nav, etc.
- #in-progress Figure out how to do metadata...should be able to extract it from Typst source files?

== Triage

- #todo Set up syntax highlighting with #link("https://docs.rs/syntect/latest/syntect/html/index.html")[syntect] or #link("https://github.com/tree-sitter/tree-sitter/tree/master/highlight")[tree-sitter-highlight].

== Done

- #done Set up TailwindCSS and a nice Big Beautiful Stylesheet.
- #done Basic utilities with interacting with the world, e.g. Typst compiler, build intermediate artifacts.
  - #done Typst compiler wrapper
  - #done Build list of Typst dirs into HTML outputs
  - #done Automatically generate routes using Typst. The rule for this should
    be a special dir (routes?) where capitalized filename (e.g. `About.typ`)
    or nested directory (e.g. `about/Me.typ`) indicates routes.
- #done Ingest a rendered HTML artifact and then process it to remove `<head>` and `<doctype>` tags amongst other extraneous tags.
- #done "nested" templating for implementing Navbar.

== Wishlist

- Advanced print functionality: by compiling a PDF in parallel with HTML, we
  can provide each page with a beautifully typeset PDF to print/save offline
  instead of janky browser print.
