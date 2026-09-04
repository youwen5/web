---
title: "Photo Gallery"
---

#import "@preview/html-shim:0.1.0": *
#import "@preview/based:0.2.0": base64

#show: html-shim

#let parseDate(s) = {
  let (year, month, day, hour, minute, second) = s
    .match(regex("(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})"))
    .captures
    .map(int)
  datetime(
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    second: second,
  )
}

#let encodePhotoData(data) = {
  base64.encode(json.encode(data, pretty: false))
}

#let photo(data) = {
  let base-class = "p-1 hover:bg-foreground hover:text-bg space-y-1 group/child block shrink-0"
  // let final-class = if not show-in-selected {
  //   base-class + " group-[.show-selected]:hidden"
  // } else { base-class }
  let final-class = (
    base-class
      + if data.rating >= 4 {
        " group-[.show-selected]:hidden"
      } else { "" }
  )

  html.elem(
    "a",
    attrs: (
      href: "/photos/viewer?data="
        + encodePhotoData({
          let exportData = data
          let _ = exportData.remove("web-url")

          exportData
        })
        + "#display",
      target: "_blank",
      class: final-class,
    ),
    {
      html.img(
        src: data.fullres,
        alt: data.alt,
        loading: "lazy",
      )
      html.elem(
        "div",
        attrs: (
          class: "text-base px-1 w-0 min-w-full whitespace-normal break-words",
        ),
        [
          #html.elem(
            "span",
            attrs: (
              class: "text-sm text-subtle group-hover/child:text-bg leading-none",
            ),
            [
              #data.date
              #if data.location != none [
                @ #data.location
              ]
              ·
              #(data.focal-length)mm
              ·
              f/#(data.f-number)
              ·
              1⁄#data.shutter
              ·
              ISO #data.iso
              ·
              #let cameraModel = if data.camera.model == "ILCE-7CM2" [
                #(sym.alpha)7Cii
              ] else { data.camera.model }
              #data.camera.make #cameraModel
            ],
          )
          #if data.caption != none [
            \
            #data.caption
          ]
        ],
      )
    },
  )
}

#html.div(class: "flex flex-col gap-4 mx-auto w-fit mb-8", {
  html.elem(
    "div",
    attrs: (
      class: "px-3 py-1 text-base rounded-md border-1 border-zinc-300 dark:border-zinc-700 text-subtle font-sans space-x-6 w-fit w-fit not-prose h-full mx-auto",
    ),
    {
      html.elem(
        "button",
        attrs: (
          class: "before:content-['●'] before:text-[0.55em] before:text-foam before:pr-2 my-auto inline-flex before:my-auto cursor-pointer",
          id: "all-photos-button",
        ),
        [All],
      )
      html.elem(
        "button",
        attrs: (
          class: "before:content-['○'] before:text-[0.55em] before:pr-2 inline-flex my-auto before:my-auto hover:before:content-['●'] cursor-pointer",
          id: "selected-photos-button",
        ),
        [Curated only],
      )
    },
  )

  html.elem(
    "div",
    attrs: (
      class: "hidden md:flex px-3 py-1 text-base rounded-md border-1 border-zinc-300 dark:border-zinc-700 text-subtle font-sans gap-x-6 w-fit not-prose h-full flex-wrap mx-auto",
    ),
    {
      html.elem(
        "button",
        attrs: (
          class: "my-auto inline-flex before:my-auto cursor-pointer hover:text-foam text-foam",
          id: "layout_scroll_vert",
        ),
        [#lucide-icon(name: "gallery-vertical")],
      )
      html.elem(
        "button",
        attrs: (
          class: "my-auto inline-flex before:my-auto cursor-pointer hover:text-foam",
          id: "layout_scroll_horiz",
        ),
        [#lucide-icon(name: "gallery-horizontal")],
      )
      html.elem(
        "button",
        attrs: (
          class: "my-auto inline-flex before:my-auto cursor-pointer hover:text-foam",
          id: "layout_tile_double",
        ),
        [#lucide-icon(name: "grid-2x2")],
      )
      html.elem(
        "button",
        attrs: (
          class: "my-auto inline-flex before:my-auto cursor-pointer hover:text-foam",
          id: "layout_tile_triple",
        ),
        [#lucide-icon(name: "grid-3x3")],
      )
    },
  )
})

#let photo-urls = (
  json("manifest.json")
    .photos
    .map(x => (
      web-url: x.webUrl,
      fullres: x.originalUrl,
      date: parseDate(x.exif.at("capturedAt", default: x.uploadedAt)).display(
        "[day padding:zero] [month repr:short], [year]",
      ),
      caption: if x.at("description", default: none) != none {
        x.description
      } else { none },
      alt: x.altText,
      location: {
        let city = x.location.at("city", default: none)
        let country = x.location.at("country", default: none)

        if (city == none) and (country == none) { none } else if (
          city == none
        ) { "Somewhere, " + country } else if (
          country == none
        ) { city + ", Earth" } else { city + ", " + country }
      },
      camera: (make: x.exif.cameraMake, model: x.exif.cameraModel),
      focal-length: x.exif.focalLength35mmEquivalent,
      f-number: x.exif.fNumber,
      shutter: str(100 / x.exif.exposureTimeSeconds),
      iso: x.exif.iso,
      mp: x.megapixels,
      rating: if x.rating == none { 0 } else { x.rating },
    ))
)

#html.elem(
  "div",
  attrs: (
    class: "layout-vert gap-8 mt-4 group not-prose photos-img-thumb mx-auto",
    id: "photos-container",
  ),
  for elem in (
    photo-urls.map(it => photo(it))
  ) {
    elem
  },
)

// yup, i wrote all of this js as plaintext by hand in this typst string w/o
// syntax highlighting or an LLM (well, it's not very complex anyways lol)
#html.elem(
  "script",
  "
const selected = document.getElementById('selected-photos-button');
const all = document.getElementById('all-photos-button');
const photos_parent = document.getElementById('photos-container');

const selected_class = all.className;
const unselected_class = selected.className;

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

const layout_scroll_vert = document.getElementById('layout_scroll_vert');
const layout_scroll_horiz = document.getElementById('layout_scroll_horiz');
const layout_tile_double = document.getElementById('layout_tile_double');
const layout_tile_triple = document.getElementById('layout_tile_triple');

const layout_selected_class = layout_scroll_vert.className;
const layout_unselected_class = layout_scroll_horiz.className;

const switch_to = layout => {
  const layouts = ['layout-vert', 'layout-horiz', 'layout-tile-double', 'layout-tile-triple'];

  layouts.filter(x => x !== layout).forEach(y => {
    photos_parent.classList.remove(y);
  });

  photos_parent.classList.add(layout);

  const photos_container = document.getElementById('photos-container');

  if (layout === 'layout-vert') {
    photos_container.classList.add('max-w-[800px]');
  } else {
    photos_container.classList.remove('max-w-[800px]');
  }

  if (layout === 'layout-tile-double' || layout === 'layout-tile-triple') {
    photos_container.classList.remove('photos-img-thumb');
    photos_container.classList.remove('photos-img-thumb-height');
    photos_container.classList.add('photos-img-thumb-aspect');
  } else if (layout === 'layout-horiz') {
    photos_container.classList.remove('photos-img-thumb');
    photos_container.classList.add('photos-img-thumb-height');
    photos_container.classList.remove('photos-img-thumb-aspect');
  } else {
    photos_container.classList.add('photos-img-thumb');
    photos_container.classList.remove('photos-img-thumb-height');
    photos_container.classList.remove('photos-img-thumb-aspect');
  }
}

switch_to('layout-vert');

layout_scroll_vert.addEventListener('click', () => {
  layout_scroll_vert.className = layout_selected_class;
  layout_scroll_horiz.className = layout_unselected_class;
  layout_tile_double.className = layout_unselected_class;
  layout_tile_triple.className = layout_unselected_class;

  switch_to('layout-vert');
});

layout_scroll_horiz.addEventListener('click', () => {
  layout_scroll_vert.className = layout_unselected_class;
  layout_scroll_horiz.className = layout_selected_class;
  layout_tile_double.className = layout_unselected_class;
  layout_tile_triple.className = layout_unselected_class;

  switch_to('layout-horiz');
});

layout_tile_double.addEventListener('click', () => {
  layout_scroll_vert.className = layout_unselected_class;
  layout_scroll_horiz.className = layout_unselected_class;
  layout_tile_double.className = layout_selected_class;
  layout_tile_triple.className = layout_unselected_class;

  switch_to('layout-tile-double');
});

layout_tile_triple.addEventListener('click', () => {
  layout_scroll_vert.className = layout_unselected_class;
  layout_scroll_horiz.className = layout_unselected_class;
  layout_tile_double.className = layout_unselected_class;
  layout_tile_triple.className = layout_selected_class;

  switch_to('layout-tile-triple');
});
",
)
