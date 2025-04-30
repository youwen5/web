#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(title: "Luminite")

#let done = emoji.checkmark.box
#let todo = sym.ballot
#let in-progress = emoji.clock

This is the software that builds this website. It is a custom system for
building a static site generator using Typst as the primary way of setting
content. This page is my todo-board where I plan out and track feature
implementation. The source code is available on
#link("https://github.com/youwen5/web")[GitHub].

Big picture next steps: get metadata working, and generate some more advanced
pages that rely on introspecting the system at build time. Then work on
smoothing around the corners, hot reload, caching.

= Started

- #in-progress Set up a templating system that can embed the HTML (see #link("https://github.com/vidhanio/hypertext")[hypertext]).
  - #in-progress Introspection on the site at build time.
  - #done Integrate metadata system into templating system.
  - #done Component system so site can share common header, footer, nav, etc.

= Triage

- #todo Set up syntax highlighting with #link("https://docs.rs/syntect/latest/syntect/html/index.html")[syntect] or #link("https://github.com/tree-sitter/tree-sitter/tree/master/highlight")[tree-sitter-highlight].
- #todo Set up the meta-pages that collect posts automatically.
- #todo #smallcaps[rss]/Atom feed.
- #todo Allow some routes to be PDFs instead of webpages. So e.g. we could introduce a file pattern like `$doc.typ` and in the place where it would've been as a webpage, it's a PDF instead.

= Done

- #done Set up TailwindCSS and a nice Big Beautiful Stylesheet.
- #done Basic utilities with interacting with the world, e.g. Typst compiler, build intermediate artifacts.
  - #done Typst compiler wrapper
  - #done Build list of Typst dirs into HTML outputs
  - #done Automatically generate routes using Typst. The rule for this should
    be a special dir (routes?) where capitalized filename (e.g. `About.typ`)
    or nested directory (e.g. `about/Me.typ`) indicates routes.
- #done Ingest a rendered HTML artifact and then process it to remove `<head>` and `<doctype>` tags amongst other extraneous tags.
- #done "nested" templating for implementing Navbar.
- #done Figure out how to do metadata...should be able to extract it from Typst source files?
  - #done Metadata is now possible, but slow. I'm thinking of doing a cache system where we keep a `.json` or `.toml` file that caches extracted metadata in `.luminite` for fast development (and a switch in the code to skip inspecting metadata and trust the cache).
    - Eventually once we have file-watching hot reload this file will work better. But it's faster than multi-second build steps.
    - Maybe also look into extracting multiple pieces of metadata at once. If not possible in Typst CLI, then will have to wait until CLI is replaced by embedding the `typst` create directly.
    - NOTE: I've marked this task done but the above has not been implemented. Rather I've just figured out how to make it much faster by parsing JSON out of a single query. However hot reload is still in question.

= Wishlist

- Advanced print functionality: by compiling a PDF in parallel with HTML, we
  can provide each page with a beautifully typeset PDF to print/save offline
  instead of janky browser print.
  - Could use `typst.ts`
- Comments system, using #smallcaps[htmx]?
