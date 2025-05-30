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
  extraFigureClass: none,
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
          attrs: (class: "text-[0.88em] text-center"),
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

// A smart link that newtabs any external link
#let link(newtab: none, ..args) = context {
  let dest = args.pos().at(0)
  let body = args.pos().at(1)
  let newtab = if newtab != none { newtab } else {
    if dest.starts-with("/") {
      false
    } else {
      true
    }
  }
  if target() == "html" {
    if newtab {
      html.elem(
        "a",
        attrs: (class: "text-link external-link", href: dest, target: "_blank"),
        body,
      )
    } else {
      html.elem(
        "a",
        attrs: (class: "text-link internal-link", href: dest),
        body,
      )
    }
  } else {
    std-link(dest, body)
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
    set text(size: 1.2em)
    if not math-escape-mode {
      html.elem(
        "span",
        attrs: (role: "math", class: "math inline-math"),
        html.frame(it),
      )
    } else { it }
  }


  show math.equation.where(block: true): it => {
    set text(size: 1.2em)
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
