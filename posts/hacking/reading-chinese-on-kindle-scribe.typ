---
title: "How to set up Kindle Scribe for reading Chinese"
published: 2025-09-13
---

// date: datetime(day: 13, year: 2025, month: 5),
// location: "San Francisco, California",
// enable-comments: true,
// thumbnail: "https://m.media-amazon.com/images/I/818lMOyWkRL._UF1000,1000_QL80_.jpg",

#import "@preview/html-shim:0.1.0": *
#import "@preview/cmarker:0.1.5"

#show: html-shim

Kindles are no longer sold in Mainland China, but it is still surprisingly
pleasant for reading Chinese (and CJK in general!).

This article will specifically target the Scribe, but it should also work on the latest other models.

Here's the deal: the Kindle is definitely designed for a Latin-reading
audience. It comes with a large selection of Latin fonts and no CJK fonts. Many
Chinese books are not available on the e-bookstore. The latter is an easy fix;
you can obtain Chinese ebooks however you like from other storefronts and load
them onto the Kindle through Calibre or your preferred methods. However, the
issue remains of font selection. By default, CJK characters _are_ displayed,
but switches weirdly between sans and serif (Song/Ming) glyphs. Also, if you
don't like the builtin system font, tough luck.

Luckily, the Kindle actually allows you to load custom fonts, a little-known
feature. All you have to do is download the fonts onto your computer and drop
them into the `fonts/` directory in the Kindle filesystem.

#btw[
  You can also use the method below to load your favorite Latin fonts! I loaded
  my preferred font, #link("https://mbtype.com/fonts/valkyrie/")[Valkyrie] by
  Matthew Butterick, also the typeface for body text on this website, and now I
  can enjoy it when reading all of my books.
]

= Loading fonts

For Windows users: this is easy. Just plug in the Kindle and it should show up
shortly in File Explorer.

For Linux users---not so easy. Older Kindles acted as USB Mass Storage devices,
so they would show up as a USB Drive. The Scribe, and presumably other newer
devices, use the
#link("https://en.wikipedia.org/wiki/Media_Transfer_Protocol")[Media Transfer
  Protocol (MTP)]. This means that `lsblk` or `fdisk -l` will not bring up the
Scribe's filesystem and you can't just use `mount(8)` to access it, unlike what
the top results on Google would suggest.

All you will need is a way to access an MTP filesystem. If you are using
#smallcaps[GNOME], this should require no action on your part. The
#smallcaps[gnome] #link("https://en.wikipedia.org/wiki/GVfs")[GVfs] should
support MTP out of the box, and you should be able to find it in Nautilus (also
called "Files"). On my end, I'm running NixOS with Hyprland, but I have
GVfs and Nautilus installed anyways, so that's what I used.

Whichever way you chose to open the file system, simply peruse the Kindle's
files until you quickly find the `fonts` folder, then drop in your font of
choice. I recommend the Noto CJK family, and the Song/Ming style. By the way,
variable fonts are supported too!

To obtain Noto CJK, a free font developed by Google, you can grab it from the
#link("https://github.com/notofonts/noto-cjk")[GitHub repository]. Noto Serif
CJK Simplified Chinese in particular can be found in #link("https://github.com/notofonts/noto-cjk/tree/main/Serif/Variable/OTF")[this
  directory].
Click the file "NotoSerifCJKsc-VF.otf" and then hit the #quote[Download
  Raw] icon in the top right (it looks like an arrow pointing down into a
bracket). (Note the other files are Noto Serif fonts for Traditional Chinese,
Japanese, Korean, and Hong Kong Traditional Chinese, which can be installed
similarly.)

After downloading it, simply move the OTF file into the `fonts/` directory on
the Kindle, disconnect it from your computer, and then it will show up
alongside the builtin fonts in the menu!
