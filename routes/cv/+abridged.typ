#import "@luminite/html-shim:0.1.0": *
#import "./pesha.typ": *
#import "./common.typ": render-cv

#show: html-shim.with(
  title: "Curriculum Vitae",
  date: datetime(day: 11, month: 5, year: 2025),
  meta-description: "Youwen's resume / CV.",
  also-compile-pdf: true,
)

#show: it => context {
  if target() != "html" {
    set heading(depth: 3)
    show: pesha.with(
      name: "Youwen Wu",
      address: "Curriculum Vitae",
      contacts: (
        [(925) 791 1845],
        [#link("mailto:youwen@ucsb.edu")],
      ),
      footer-text: [Wu Résumé],
    )
    it
  } else {
    it
  }
}

#render-cv()
