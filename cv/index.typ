#import "@preview/html-shim:0.1.0": *
#import "./pesha.typ": *
#import "./common.typ": render-cv

#show: html-shim

#show: it => context {
  if target() != "html" {
    set heading(depth: 3)
    show: pesha.with(
      name: "Youwen Wu",
      address: "Berkeley, CA",
      contacts: (
        [(925)--791--1845],
        [#link("mailto:youwen@berkeley.edu", smallcaps(
          all: true,
        )[youwen\@berkeley.edu])],
        [#link("https://web.youwen.dev")[web.youwen.dev]],
      ),
      footer-text: [Curriculum Vitae],
    )
    it
  } else {
    it
  }
}


#render-cv(long: true)
