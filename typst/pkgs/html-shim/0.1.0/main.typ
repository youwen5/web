// Adds support for HTML-based math rendering
#import "@preview/bullseye:0.1.0": *
#import "@preview/showybox:2.0.4": showybox

#let blockquote = (attribution: none, body) => context {
  if target() == "html" {
    html.elem(
      "blockquote",
      attrs: (
        class: "border-l-solid border-l-4 border-l-subtle px-4 w-fit text-[0.9em]",
      ),
      {
        body
        if attribution != none {
          html.elem(
            "div",
            attrs: (class: "w-fit ml-auto text-subtle"),
            attribution,
          )
        }
      },
    )
  }
}

#let dinkus = context {
  if target() == "html" {
    html.elem("hr")
    html.elem(
      "div",
      attrs: (class: "w-full text-center text-xl text-subtle select-none"),
      [⁂],
    )
  } else {
    [⁂]
  }
}

#let tombstone = context {
  if target() == "html" {
    html.elem(
      "div",
      attrs: (
        class: "inline-flex justify-end w-full text-xl dark:invert -mt-4",
      ),
      {
        set text(2.5em)
        html.frame(sym.square.filled)
      },
    )
  } else {
    sym.square.filled
  }
}

#let webimg = (
  src,
  alt,
  caption: none,
  extraImgClass: none,
  extraFigureClass: "",
) => context {
  if target() == "html" {
    let base-img-classes = "rounded-md mx-auto shadow-sm dark:shadow-none shadow-gray-900"
    let img-classes = if extraImgClass != none {
      base-img-classes + " " + extraImgClass
    } else {
      base-img-classes
    }
    let img = html.elem("img", attrs: (
      src: src,
      alt: alt,
      class: img-classes,
      loading: "lazy",
    ))
    if caption == none {
      img
    } else {
      html.elem("figure", attrs: (class: extraFigureClass), {
        img
        html.elem(
          "figcaption",
          attrs: (class: "text-[0.88em] text-center text-subtle"),
          caption,
        )
      })
    }
  } else [
    Sorry, web images cannot be embedded in PDFs.
  ]
}

#let lucide-icon(name: "", class: "") = context {
  if target() == "html" {
    if class != "" {
      html.elem("i", attrs: (data-lucide: name, class: class))
    } else {
      html.elem("i", attrs: (data-lucide: name))
    }
  }
}

#let dropcap(body) = context {
  if target() == "html" {
    html.elem("p", attrs: (class: "subhead"), body)
  } else {
    body
  }
}

#let apostrophe = sym.quote.r.single

#let btw(body) = context {
  if target() == "html" {
    html.elem(
      "div",
      attrs: (
        class: "py-2 px-4 text-[0.8em] rounded-md border-1 border-slate-200 dark:border-zinc-700 bg-slate-50 dark:bg-overlay leading-[1.5em]",
      ),
      {
        html.elem("div", smallcaps(all: true)[By the way])
        html.elem(
          "div",
          attrs: (class: "!mb-0 mt-2 prose-p:mb-0 prose-p:mt-3"),
          {
            body
          },
        )
      },
    )
  } else {
    showybox(
      title-style: (
        weight: 900,
        color: blue.darken(40%),
        sep-thickness: 0pt,
        align: center,
      ),
      frame: (
        title-color: blue.lighten(80%),
        border-color: blue.darken(40%),
        thickness: (left: 1pt),
        radius: 0pt,
      ),
      title: "By the way",
      body,
    )
  }
}

#let std-link = link

// A smart link for the web. Pass in newtab or internal explicitly to set these, otherwise they will be auto-detected.
#let link(newtab: none, internal: none, ..args) = context {
  let dest = args.pos().at(0)
  let body = args.pos().at(1)
  let internal = if internal != none { internal } else { dest.starts-with("/") }
  let newtab = if newtab != none { newtab } else { not internal }
  let link-class = (
    "text-link " + if internal { "internal-link" } else { "external-link" }
  )
  if target() == "html" {
    if newtab {
      html.elem(
        "a",
        attrs: (class: link-class, href: dest, target: "_blank"),
        body,
      )
    } else {
      html.elem("a", attrs: (class: link-class, href: dest), body)
    }
  } else {
    std-link(..args)
  }
}

#let std-figure = figure
#let figure(math: true, ..args) = context {
  if target() == "html" {
    let figureClass = if math { "math block-math" } else { "" }
    show std-figure: it => context {
      if target() == "html" {
        html.elem("figure", attrs: (class: figureClass), {
          html.frame(it.body)
          it.caption
        })
      } else {
        it
      }
    }

    std-figure(..args)
  } else {
    std-figure(..args)
  }
}

#let html-shim(body) = {
  show math.equation.where(block: true): it => context {
    if target() == "html" {
      html.elem(
        "div",
        attrs: (role: "math", class: "math block-math inline-block"),
        html.frame(it),
      )
    } else {
      it
    }
  }
  show math.equation.where(block: false): it => context {
    if target() == "html" {
      html.elem(
        "span",
        attrs: (role: "math", class: "math inline-math"),
        html.frame(it),
      )
    } else {
      it
    }
  }

  show footnote: it => {
    if target() == "html" {
      show super: it2 => {
        html.elem(
          "sup",
          attrs: (
            class: "font-index text-iris text-[0.83em] hover:bg-love/15 transition-colors] ml-0.5 [vertical-align: baseline] relative -top-[0.33em]",
          ),
          [#it2.body],
        )
      }
      it
    } else {
      it
    }
  }

  show smallcaps: it => context {
    if target() == "html" {
      let smallcapsClass = if it.all {
        "all-smallcaps"
      } else {
        "smallcaps"
      }

      show text: it2 => html.elem(
        "span",
        attrs: (class: "inline-block " + smallcapsClass),
        it2,
      )

      it
    } else {
      it
    }
  }

  body
}
