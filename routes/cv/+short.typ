#import "@preview/html-shim:0.1.0": *
#import "./pesha.typ": *
#import "./common.typ": render-cv

#show: html-shim.with(
  title: "Curriculum Vitae",
  date: datetime(day: 11, month: 5, year: 2025),
  meta-description: "Youwen's resume / CV.",
  also-compile-pdf: true,
  pdf-filename: "youwen-wu-cv-short",
)

#show: it => context {
  if target() != "html" {
    set heading(depth: 3)
    show: pesha.with(
      name: "Youwen Wu",
      address: "Santa Barbara, CA | Danville, CA",
      contacts: (
        [(925)--791--1845],
        [#link("mailto:youwen@cs.ucsb.edu", smallcaps(
          all: true,
        )[youwen\@cs.ucsb.edu])],
        [#link("https://web.youwen.dev")[web.youwen.dev]],
      ),
      footer-text: [Curriculum Vitae],
    )
    it
  } else {
    it
  }
}


#render-cv()
