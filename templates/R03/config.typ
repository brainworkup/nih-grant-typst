#let nih-grant(
  title: "Title of R03 Grant Application",
  pi: "Principal Investigator",
  institution: "Research Institution",
  body
) = {
  // Page setup for NIH grants
  set page(
    paper: "us-letter",
    margin: (left: 0.5in, right: 0.5in, top: 0.5in, bottom: 0.5in),
    numbering: "1",
    number-align: center,
  )

  // Font settings
  set text(font: "Helvetica", size: 11pt)
  set par(justify: true, leading: 0.8em)

  // Headings configuration
  set heading(numbering: none)
  show heading.where(level: 1): it => {
    set text(weight: "bold", size: 12pt)
    set block(above: 1.5em, below: 0.5em)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", size: 11pt)
    set block(above: 1em, below: 0.5em)
    it
  }

  // Title block
  align(center)[
    #text(weight: "bold", size: 14pt)[#title]
    #v(0.5em)
    #text(style: "italic")[#pi, #institution]
    #v(1em)
    #line(length: 100%)
  ]

  // Document body
  body
}

// Function for specific aims section
#let specific_aims(content) = {
  heading(level: 1, [SPECIFIC AIMS])
  content
}

// Function for research strategy section
#let research_strategy(significance, innovation, approach) = {
  heading(level: 1, [RESEARCH STRATEGY])

  heading(level: 2, [Significance])
  significance

  heading(level: 2, [Innovation])
  innovation

  heading(level: 2, [Approach])
  approach
}

// Function for bibliography section
#let references(bibfile) = {
  heading(level: 1, [BIBLIOGRAPHY & REFERENCES CITED])
  bibliography(bibfile)
}
