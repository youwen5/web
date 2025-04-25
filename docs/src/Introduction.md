# Luminite

This is a system for building a static site generator using Typst as the
primary way of setting content.

## MVP

Minimum viability level to begin dogfooding this project in a personal site is
being able to build simple HTML pages with content from Typst documents.

Ideally, we'd like to use some sort of templating language to write hypermedia
(HTML/HTMX), and then embed the rendered HTML inside. We want this to be flexible.

It is not yet fully decided, but the final software will likely be a library
that provides utilities for creating a static site generator a la Hakyll, but
centered around Typst. Thus all configuration will be done in Rust files.

## Started

- [ ] Basic utilities with interacting with the world, e.g. Typst compiler, build intermediate artifacts.
  - [x] Typst compiler wrapper
  - [x] Build list of Typst dirs into HTML outputs
  - [ ] Automatically generate routes using Typst. The rule for this should
        be a special dir (routes?) where capitalized filename (e.g. `About.typ`)
        or nested directory (e.g. `about/Me.typ`) indicates routes.

## Triage

- [ ] Ingest a rendered HTML artifact and then process it to remove `<head>` and `<doctype>` tags amongst other extraneous tags.
- [ ] Set up a templating system that can embed the HTML (see [hypertext](https://github.com/vidhanio/hypertext)).
- [ ] Set up TailwindCSS and a nice Big Beautiful Stylesheet.
- [ ] Figure out how to do metadata...should be able to extract it from Typst source files?
- [ ] "nested" templating for implementing Navbar.

## Wishlist

- Advanced print functionality: by compiling a PDF in parallel with HTML, we
  can provide each page with a beautifully typeset PDF to print/save offline
  instead of janky browser print.
