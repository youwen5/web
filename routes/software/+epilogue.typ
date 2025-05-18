#import "@epilogue/html-shim:0.1.0": *

#show: html-shim.with(
  title: "How this website was made",
  subtitle: "Introducing Epilogue, my static site generator based on Typst.",
)

#let done = emoji.checkmark.box
#let todo = sym.ballot
#let in-progress = emoji.clock

Back when I was shopping around for a framework to write this website in, I
realized there was a serious gap in the ecosystem. The entire web development
culture of churning out framework after framework and package after package is
#link("https://en.wikipedia.org/wiki/Npm_left-pad_incident")[well documented]
at this point. There are also myriad great static site generators that have
been established for years. So it feels strange to declare that, actually, we
don#(apostrophe)t have _enough_ choice already.

But I think it#(apostrophe)s true. Let#(apostrophe)s briefly analyze two
primary ways content driven sites are deployed to the web, in so-called
#quote[modern web development]. One: choose a web framework, and write in that.
Two: use a static site generator, create some #smallcaps[html] templates, and
write in Markdown or a similarly minimalistic markup language. (Three: a
combination of both, like #link("https://astro.build/")[Astro].)

There#(apostrophe)s a time and place for web frameworks. I#(apostrophe)m
partial to Astro and Svelte. But for a personal website? Hell no.
I#(apostrophe)m not going to depend on 1000 #smallcaps[npm] packages and ship
users ten thousand lines of JavaScript for three interactive widgets and an
image carousel.

I think Markdown is fine, but we can seriously do better. Markdown is for when
you#(apostrophe)re writing in a GitHub `README` and want some basic formatting.
It#(apostrophe)s rather austere for a markup language that generates content on
a website you control. What if you want to define a custom reusable component?
What if you want to programmatically do anything?

Of course there are systems to give you more power
#footnote[#link("https://mdxjs.com/")[MDX]], but at the end of the day
you#(apostrophe)re either hacking a programming system into a markup language
or a markup language into a programming system. The gold standard would be an
actual markup language that treats programming as a first class citizen, or,
equivalently, a programming language where markup is a first class citizen.

#let TeXRaw = {
  set text(font: "New Computer Modern")
  let t = "T"
  let e = text(baseline: 0.22em, "E")
  let x = "X"
  box(t + h(-0.14em) + e + h(-0.14em) + x)
}

#let TeX = {
  $TeXRaw$
}

#let LaTeX = {
  set text(font: "New Computer Modern")
  let l = "L"
  let a = text(baseline: -0.35em, size: 0.66em, "A")
  $#box(l + h(-0.32em) + a + h(-0.13em) + TeXRaw)$
}

This is where Typst comes in. In Typst, markup and code are fused into one.
Typst is like #LaTeX, in that it#(apostrophe)s programmatic and scriptable.
Typst is like Markdown, in that basic markup (paragraphs, lists, tables,
headings, etc.) is easy to use with dedicated syntax. But it has a much better
scripting language than #TeX while being just as easy as Markdown. And, despite
its primary purpose being to output beautifully typeset #smallcaps[pdf]
documents like #TeX, it has #smallcaps[html] export that is surprisingly easy
to use. So instead of relying on third-party conversion utilities like
#link("https://pandoc.org/")[Pandoc], you can access the full power of the
Typst language and not worry about things getting lost in translation during conversion.

Enough evangelizing. How does this website actually work? This website is
generated in Typst, but it was missing some pieces. Typst doesn#(apostrophe)t
understand intrinsically how to render a collection of #smallcaps[html] pages
into a website, so I hacked some additional infrastructure together. I wrote a
tiny (1.3k lines of safe Rust code) static site generator called Epilogue that can
parse a directory of Typst documents---representing routes---and then build it
into a website. It works pretty well (you#(apostrophe)re reading text generated
by Typst right now).

Is it actually usable? Surprisingly, yes. I#(apostrophe)ve implemented a system
for obtaining metadata from Typst documents, so we can populate the website
`<head>` for SEO. Almost every element on this site (with the exception of the
navigation elements) is written somewhere in a Typst source file. I implemented
a thread pooled parallel compilation infrastructure so I can build hundreds of
pages in a few seconds. I can basically do everything expected of a simple
markdown static site generator right now.

Remember those snazzy #LaTeX and #TeX symbols earlier? They#(apostrophe)re
rendered directly as embedded #smallcaps[svg]s, from this source code (stolen
shamelessly from
#link("https://github.com/typst/typst/discussions/1732", newtab: true)[swaits on the Typst GitHub]):

```typst
#let TeXRaw = {
  set text(font: "New Computer Modern")
  let t = "T"
  let e = text(baseline: 0.22em, "E")
  let x = "X"
  box(t + h(-0.14em) + e + h(-0.14em) + x)
}

#let TeX = {
  $TeXRaw$
}

#let LaTeX = {
  set text(font: "New Computer Modern")
  let l = "L"
  let a = text(baseline: -0.35em, size: 0.66em, "A")
  $#box(l + h(-0.32em) + a + h(-0.13em) + TeXRaw)$
}
```

Try doing that with Markdown or React!

There are a few essential features I still need to add though. We can get
information out of a document, but we still need to pass information back
in---for example, we might pass in a list of recent blog posts for rendering a
feed. I also want stuff like Atom/RSS feeds. But overall, it#(apostrophe)s
everything I want out of a static site generator---namely, the actual
experience of writing markup is amazing thanks to Typst. I can define
functions, create libraries for shared utilities and components, pull in
packages, introspect on my webpage, and none of it feels janky like a markdown
based solution would.

For an example of something that is only possible with Typst, see my
#link("/cv")[CV], which is available as both the webpage and a #smallcaps[pdf],
in both full and short variations, all generated from a single Typst source
file.

#blockquote(attribution: [Matthew Butterick, at the #link("https://www.youtube.com/watch?v=IMz09jYOgoc", newtab: true)[fourth RacketCon]])[
  This whole idea of having like a document compiler that can take a source
  file [and] take it to multiple platforms, publishing targets is really more
  important than ever. I can tell you from many years spent among the short
  people of the web development community that they don't really have anything
  for this.
]

= Project board

The rest of this page is my project-board where I plan out and track feature
implementation. By the way, the website and static site generator source code
is available on #link("https://github.com/youwen5/web")[GitHub].

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
  - #done Metadata is now possible, but slow. I'm thinking of doing a cache system where we keep a `.json` or `.toml` file that caches extracted metadata in `.epilogue` for fast development (and a switch in the code to skip inspecting metadata and trust the cache).
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

