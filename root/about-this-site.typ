---
title: "About this site"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#let icon(name: "") = {
  html.elem("span", attrs: (class: "my-auto w-[24px]"), lucide-icon(name: name))
}


#html.elem(
  "div",
  attrs: (class: "font-sans w-full prose-lg"),
  {
    let entry(
      href: "/impressum",
      is-link: true,
      newtab: true,
      internal: false,
      body,
    ) = {
      html.elem(
        if is-link { "a" } else { "span" },
        attrs: (
          href: href,
          target: if newtab { "_blank" } else { "" },
          class: "px-1 py-1 font-light hover:text-bg hover:bg-love border-b-1 border-b-love text-love decoration-none min-w-full inline-flex justify-between content-center min-h-[50px]",
        ),
        {
          html.elem("span", attrs: (class: "flex gap-2 my-auto"), body)
          if internal {
            icon(name: "move-right")
          } else if is-link {
            icon(name: "external-link")
          }
        },
      )
    }
    entry(href: "/licensing", internal: true, newtab: false, {
      icon(name: "scale")
      [Content licensing]
    })

    entry(href: "/acknowledgements", internal: true, newtab: false, {
      icon(name: "square-code")
      [Open source and acknowledgements]
    })

    entry(href: "/colophon", newtab: false, internal: true, {
      icon(name: "ruler-dimension-line")
      [Colophon]
    })

    entry(href: "/accessibility", internal: true, newtab: false, {
      icon(name: "accessibility")
      [Accessibility statement]
    })

    entry(href: "/privacy", internal: true, newtab: false, {
      icon(name: "lock-keyhole")
      [Privacy policy]
    })
  },
)
