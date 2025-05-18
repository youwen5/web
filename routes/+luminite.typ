#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(title: "Luminite")

#let done = emoji.checkmark.box
#let todo = sym.ballot
#let in-progress = emoji.clock

#blockquote[
  Write JavaScript like it's 2005.
]

This is the software that generates this website. It is a custom system for
building a static site generator built around Typst. This page is my
project-board where I plan out and track feature implementation. The source
code is available on #link("https://github.com/youwen5/web")[GitHub].

General next steps: now that we can pass data from each document to the site
generator, we need to figure out how to pass data from the site generator back
into the document, so that we can generate things like RSS feeds, navigation
pages, sitemaps, etc.

= Started

- #in-progress Set up a templating system that can embed the HTML (see #link("https://github.com/vidhanio/hypertext")[hypertext]).
  - #in-progress Introspection on the site at build time.
  - #done Integrate metadata system into templating system.
  - #done Component system so site can share common header, footer, nav, etc.

= Triage

- #todo Set up the meta-pages that collect posts automatically.
  - #todo Figure out how to pass data from the static site generator back into the website.
- #todo #smallcaps[rss]/Atom feed.
- #todo Figure out how image hosting will work
  - #todo #smallcaps[cdn]? That would introduce complexity, but I don't like the idea of hosting static assets in GitHub using gh pages
    - #todo Would have to set up deployment pipeline
    - #todo Alternatively could move hosting off of gh pages and onto a personal server. Would have to write some sort of `axum` backend for this site (thus making it no longer static)
    I think I have an idea for this. We obviously don't want to store big files
    in the source tree of this site---instead, I could store files using a
    version control system for large files like Syncthing. We'd push all our
    blobs to an S3-compatible bucket, like Cloudflare R2. Then, it remains to
    implement a tiny utility that can crawl the blob storage and generate a
    machine-readable manifest, tagging some sort of unique ID to each blob. In
    this website, then, we could read this manifest (for reproducibility, it
    would be published via a Git repository and tracked as a Nix flake input).
    When referencing images and files in text, instead of linking directly, we
    just write the ID and it would be replaced with the real link from
    `cdn.youwen.dev` at compile time.

= Done

- #done Parallelized all expensive operations, shrinking run times by an order of magnitude.
- #done Allow some routes to be PDFs instead of webpages. So e.g. we could introduce a file pattern like `$doc.typ` and in the place where it would've been as a webpage, it's a PDF instead.
- #done Set up syntax highlighting with #link("https://docs.rs/syntect/latest/syntect/html/index.html")[syntect] or #link("https://github.com/tree-sitter/tree-sitter/tree/master/highlight")[tree-sitter-highlight].
  - Used `prism.js` for now.
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
  - Implemented partial version of this for the CV
- Comments system, using #smallcaps[htmx]?
  - Currently using Giscus.

= Testing code

Currently code highlighting is implemented using `prism.js`. In the future it may be done at compile time with more advanced methods.

```rust
impl TypstDoc {
    pub fn new(path_to_html: &Path) -> Result<TypstDoc, WorldError> {
        let doc = TypstDoc {
            source_path: path_to_html.to_path_buf(),
            metadata: None,
        };

        Ok(doc)
    }
}
```

```
#let webimg = (src, alt, extraClass: none) => {
  let base-classes = "rounded-md mx-auto shadow-sm dark:shadow-none shadow-gray-900"
  let classes = if extraClass != none {
    base-classes + " " + extraClass
  } else {
    base-classes
  }
  html.elem("img", attrs: (src: src, alt: alt, class: classes))
}
```
