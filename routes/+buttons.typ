#import "@epilogue/html-shim:0.1.0": *

#show: html-shim.with(title: "Buttons")

Here#(apostrophe)s my button, if you#(apostrophe)d like to add it to your site. Hot-linking is fine.

#html.elem("a", attrs: (
  href: "/",
))[
  #html.elem("img", attrs: (
    src: "/static/logo/button.png",
    alt: "anti-js-js-club",
    class: "w-24 mx-auto",
  ))
]

#dinkus

#html.elem("div", attrs: (class: "flex flex-wrap gap-4"), html.elem(
  "a",
  attrs: (
    target: "_blank",
    href: "https://muan.co/posts/javascript",
  ),
)[
  #html.elem("img", attrs: (
    src: "/static/img/anti-js-js-club.png",
    alt: "anti-js-js-club",
    class: "w-20",
  ))
])
