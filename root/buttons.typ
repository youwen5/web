---
title: "Buttons"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

Here's my button, if you'd like to add it to your site. Hot-linking is fine.

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

#let button(src, alt, href: none, class: none) = {
  let img = html.elem("img", attrs: (
    src: src,
    alt: alt,
    class: if class != none { class } else { "w-[88px] h-[31px]" },
    height: "31px",
    width: "88px",
  ))
  if href != none {
    html.elem(
      "a",
      attrs: (
        target: "_blank",
        href: href,
        class: "w-fit h-min",
      ),
      img,
    )
  } else {
    img
  }
}

#html.elem("div", attrs: (class: "flex flex-wrap not-prose mt-8"), {
  button(
    "/static/img/anti-js-js-club.png",
    "anti-js-js-club",
    href: "https://muan.co/posts/javascript",
  )
  button("/static/img/htmldream.gif", "html")
  button("/static/img/css.gif", "css")
  button("/static/img/neovim.png", "neovim", href: "https://neovim.io")
  button("/static/img/transnow2.gif", "trans rights now")
  button("/static/img/nixos.png", "nixos", href: "https://nixos.org")
  button("/static/img/galaxy.gif", "galaxy")
  button(
    "/static/img/gpl3.gif",
    "gpl3",
    href: "https://www.gnu.org/licenses/gpl-3.0.en.html",
  )
  button("/static/img/nclinux.gif", "nclinux")
  button("/static/img/nodrugs.gif", "nodrugs")
  button("/static/img/valid-bad.gif", "valid-bad")
})
