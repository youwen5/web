---
title: "Charts"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#let chart(src, alt) = html.elem(
  "img",
  attrs: (
    src: src,
    alt: alt,
    class: "rounded-md border-1 border-slate-200 dark:border-zinc-700 rounded-sm col-span-1",
  ),
)

#let urls = (
  (
    "https://wakatime.com/share/@018dc5b8-ba5a-4572-a38a-b526d1b28240/1d8813fb-b9d9-468f-9e26-2b1d9b58a4a8.svg",
    "languages over last 7 days",
  ),
  (
    "https://wakatime.com/share/@018dc5b8-ba5a-4572-a38a-b526d1b28240/3adf7a02-d840-4767-98a7-39d9ab38a5ad.svg",
    "editors pie chart",
  ),
  (
    "https://wakatime.com/share/@018dc5b8-ba5a-4572-a38a-b526d1b28240/72e7c105-f867-4179-8192-ea242fe584cc.svg",
    "operating systems pie chart",
  ),
)

#html.elem(
  "img",
  attrs: (
    src: "https://wakatime.com/share/@018dc5b8-ba5a-4572-a38a-b526d1b28240/35c097b5-4e0c-4db9-a615-4ed334726b12.svg",
    alt: "coding activity graph",
  ),
)

#html.elem(
  "div",
  attrs: (class: "grid grid-cols-1 lg:grid-cols-2 not-prose gap-1"),
  for elem in (
    urls.map(it => chart(..it))
  ) {
    elem
  },
)
