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
) = {
  show math.equation.where(block: false): it => {
    set text(size: 1.3em)
    html.elem(
      "span",
      attrs: (role: "math", class: "math inline-math"),
      html.frame(it),
    )
  }

  show math.equation.where(block: true): it => {
    set text(size: 1.3em)
    html.elem(
      "figure",
      attrs: (role: "math", class: "math block-math inline-block"),
      html.frame(it),
    )
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

  show link: it => context {
    if target() == "html" {
      html.elem("a", attrs: (class: "text-link", href: it.dest), it.body)
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
  )

  [
    #metadata(page_metadata) <metadata>
  ]

  body
}

#let blockquote = (attribution: none, body) => context {
  if target() == "html" {
    html.elem(
      "blockquote",
      attrs: (
        class: "border-l-solid border-l-4 border-l-subtle px-4 w-fit text-[0.85em]",
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

#let webimg = (src, alt, extraClass: none) => context {
  if target() == "html" {
    let base-classes = "rounded-md mx-auto shadow-sm dark:shadow-none shadow-gray-900"
    let classes = if extraClass != none {
      base-classes + " " + extraClass
    } else {
      base-classes
    }
    html.elem("img", attrs: (src: src, alt: alt, class: classes))
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

#let apostrophe = sym.quote.r.single
