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
  }
}

#let tombstone = {
  html.elem(
    "div",
    attrs: (class: "inline-flex justify-end w-full text-xl dark:invert -mt-4"),
    {
      set text(2.5em)
      html.frame(sym.square.filled)
    },
  )
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
  }
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

#let btw(body) = html.elem(
  "div",
  attrs: (
    class: "py-2 px-4 text-[0.8em] rounded-md border-1 border-slate-200 dark:border-zinc-700 bg-slate-50 dark:bg-overlay leading-[1.5em]",
  ),
  {
    html.elem("div", smallcaps(all: true)[By the way])
    html.elem("div", attrs: (class: "!mb-0 mt-2 prose-p:mb-0 prose-p:mt-3"), {
      body
    })
  },
)

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

#let std-footnote = footnote

#let footnote(..args) = context {
  let body = args.pos().at(0)
  let numbering = if args.pos().len() > 1 {
    args.pos().at(1)
  } else {
    "1"
  }

  if target() == "html" {
    counter("custom-footnote").step()
    [~]
    html.elem(
      "span",
      attrs: (
        class: "footnote-container group",
      ),
      {
        html.elem(
          "span",
          attrs: (
            class: "footnote-tooltip font-index text-iris cursor-pointer hover:bg-love/15 transition-colors [font-feature-settings:'ss01']",
            onclick: "this.parentElement.classList.toggle('show-tooltip')",
            role: "button",
            aria-label: "Toggle footnote",
          ),
          [#counter("custom-footnote").display()],
        )
        html.elem(
          "span",
          attrs: (
            class: "sr-only group-[.show-tooltip]:hidden",
            aria-label: "Footnote content",
          ),
          body,
        )
        html.elem(
          "span",
          attrs: (
            class: "hidden group-[.show-tooltip]:block font-serif text-foreground bg-overlay p-2 my-2 text-[0.8em] border-1 border-slate-200 dark:border-zinc-700 rounded-md min-w-full footnote-body",
          ),
          {
            body
            html.elem(
              "span",
              attrs: (
                onclick: "this.parentElement.parentElement.classList.remove('show-tooltip')",
                aria-label: "Close footnote",
                role: "button",
                class: "cursor-pointer text-love all-smallcaps hover:bg-love/15 transition-colors",
              ),
              [#linebreak() #sym.lozenge close],
            )
          },
        )
      },
    )
    [~]
  } else {
    std-footnote(body, numbering: numbering)
  }
}


#let html-shim(
  body,
  date: none,
  special-author: none,
  location: none,
  title: none,
  subtitle: none,
  meta-description: none,
  short-description: none,
  enable-comments: false,
  also-compile-pdf: false,
  pdf-filename: none,
  thumbnail: none,
  math-escape-mode: false,
) = {
  counter("custom-footnote").step()

  show <rendermath>: it => {
    show math.equation.where(block: true): it => {
      html.elem(
        "figure",
        attrs: (role: "math", class: "math block-math inline-block"),
        html.frame(it),
      )
    }
    show math.equation.where(block: false): it => {
      html.elem(
        "span",
        attrs: (role: "math", class: "math inline-math"),
        html.frame(it),
      )
    }
    it
  }

  show math.equation.where(block: false): it => {
    set text(size: 1em)
    if not math-escape-mode {
      html.elem(
        "span",
        attrs: (role: "math", class: "math inline-math"),
        html.frame(it),
      )
    } else { it }
  }


  show math.equation.where(block: true): it => {
    set text(size: 1.1em)
    if not math-escape-mode {
      html.elem(
        "figure",
        attrs: (role: "math", class: "math block-math inline-block"),
        html.frame(it),
      )
    } else { it }
  }

  show figure: it => {
    html.elem("figure", attrs: (class: "math block-math"), html.frame(it))
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

  show raw.where(block: true): it => context {
    if target() == "html" {
      if it.lang == none {
        return it
      }

      html.elem("pre", html.elem(
        "code",
        attrs: (class: "language-" + it.lang),
        it.text,
      ))
    } else { it }
  }

  let date_exists = if date != none {
    date.display("[year]-[month]-[day]T00:00:00.00-08:00")
  }

  let page_metadata = (
    // ISO 3339
    date: date_exists,
    special-author: special-author,
    location: location,
    title: title,
    subtitle: subtitle,
    meta-description: meta-description,
    short-description: short-description,
    enable-comments: enable-comments,
    also-compile-pdf: also-compile-pdf,
    pdf-filename: pdf-filename,
    thumbnail: thumbnail,
  )

  [
    #metadata(page_metadata) <metadata>
  ]

  if thumbnail != none {
    webimg(thumbnail, "")
  }

  body
}
