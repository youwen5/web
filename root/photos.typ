---
title: "Photos"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

#let photo(src, caption, date, show-in-selected) = {
  let base-class = "p-1 hover:bg-foreground hover:text-bg space-y-1 group/child"
  let final-class = if not show-in-selected {
    base-class + " group-[.show-selected]:hidden"
  } else { base-class }

  html.elem(
    "a",
    attrs: (
      href: src,
      target: "_blank",
      class: final-class,
    ),
    {
      html.elem("img", attrs: (
        src: src,
        class: "w-full aspect-square lg:aspect-3/4 object-cover",
        alt: caption,
        loading: "lazy",
      ))
      html.elem("div", attrs: (class: "text-base w-full px-1"), [
        #html.elem(
          "span",
          attrs: (class: "text-sm text-subtle group-hover/child:text-bg"),
          date.display("[day padding:zero] [month repr:short], [year]"),
        ) \
        #caption
      ])
    },
  )
}

#html.elem(
  "div",
  attrs: (
    class: "px-3 py-1 text-base rounded-md border-1 border-zinc-300 dark:border-zinc-700 text-subtle font-sans flex flex-wrap gap-x-6 w-fit mt-5 mx-auto mt-12 w-fit not-prose",
  ),
  {
    html.elem(
      "button",
      attrs: (
        class: "before:content-['●'] before:text-[0.55em] before:text-foam before:pr-2 my-auto inline-flex before:my-auto cursor-pointer",
        id: "selected-photos-button",
      ),
      [Selected photos],
    )
    html.elem(
      "button",
      attrs: (
        class: "before:content-['○'] before:text-[0.55em] before:pr-2 inline-flex my-auto before:my-auto hover:before:content-['●'] cursor-pointer",
        id: "all-photos-button",
      ),
      [All photos],
    )
  },
)

#let photo-urls = (
  (
    "https://cdn.youwen.dev/IMG_5525.jpeg",
    "Moon over the Pacific, Santa Barbara",
    datetime(day: 11, month: 5, year: 2025),
    false,
  ),
  (
    "https://cdn.youwen.dev/sunset-over-berkeley.webp",
    "Sunset over UC Berkeley",
    datetime(day: 2, month: 1, year: 2025),
    true,
  ),
  (
    "https://cdn.youwen.dev/dji_fly_20240805_060926_418_1722863474220_photo_optimized.jpeg",
    "Mission Peak, Newark, California",
    datetime(day: 5, month: 8, year: 2024),
    true,
  ),
)


#html.elem(
  "div",
  attrs: (
    class: "grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mt-4 group show-selected not-prose",
    id: "photos-parent",
  ),
  for elem in (
    photo-urls.map(it => photo(..it))
  ) {
    elem
  },
)

#html.elem(
  "script",
  "
const selected = document.getElementById('selected-photos-button');
const all = document.getElementById('all-photos-button');
const photos_parent = document.getElementById('photos-parent');

const selected_class = selected.className;
const unselected_class = all.className;

selected.addEventListener('click', () => {
  selected.className = selected_class;
  all.className = unselected_class;

  photos_parent.classList.add('show-selected');
});

all.addEventListener('click', () => {
  all.className = selected_class;
  selected.className = unselected_class;

  photos_parent.classList.remove('show-selected');
});
",
)
