---
title: "Please, use real unicode quotes"
---

#import "@preview/html-shim:0.1.0": *

#show: html-shim

PSA: #"'" and #"\"" (straight quotes) are almost *never* correct. These characters
_are_ legitimate, but they are for abbreviating length, like in 6#"'" 11#"\"" (6 foot
11 inches). You should almost always be using real angled curly quotes, “” and ‘', in
prose. The correct character for abbreviations is the right single quote,
`U+2019`, '. Here's an example! Here#"'"s what not to use.

The fact that straight quotes are prevalent in internet text is merely vestigal
of our limited physical keyboard glyphs descended from typewriters---please,
let's leave these habits behind. Unicode gives us access to all the fine character
nuances of professional-quality writing in every modern program.

You can input real quotes on Linux machines that use
#link("https://wiki.archlinux.org/title/IBus")[ibus] (almost all Wayland
compositors) using the shortcut `Ctrl+Shift+U` followed by the unicode---so to
type a right single quotation mark, hit `Ctrl+Shift+U`, followed by `2019`, and
then hit enter. For inferior macOS and Windows users, consult your system help
pages.

In the `kitty` terminal, `Ctrl+Shift+U` brings up a dedicated Unicode input
panel that gives you a richer search experience. Inferior terminal glyphs
end with us!

Please consult the tables below.

#table(
  columns: 3,
  table.header([Name], [Symbol], [Unicode]),
  [Left single quotation mark], [‘], [`U+2018`],
  [Right single quotation mark], [’], [`U+2019`],
  [Left double quotation mark], [“], [`U+201c`],
  [Right double quotation mark], [”], [`U+201d`],
)

While we're at it, please consider the three different dashes:

#table(
  columns: 5,
  table.header([Name], [Symbol], [Unicode], [Use], [Example]),
  [Hyphen],
  [-],
  [The regular dash on your keyboard],
  [Phrasal adjectives, multipart words],
  [High-school, cost-effective],

  [En-dash],
  [–],
  [`U+2013`],
  [Range (of numbers, values), connection or contrast],
  [page 380–390, conservative–liberal],

  [Em-dash],
  [—],
  [`U+2014`],
  [Break between parts of sentences],
  [Em-dashes put a pause in the text—for when a comma doesn't feel right.],
)

#btw[
  The typesetting system Typst will automatically convert the bad quotes (#"'" and
  #"\"") to the real ones.

  You can also type `---` and `--` to get real unicode em and en dashes in the
  output.

  For users of inferior typesetting software, _use the real unicode symbols_!
]
