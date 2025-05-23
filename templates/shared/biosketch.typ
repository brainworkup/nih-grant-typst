// NIH Biographical Sketch Template
// According to NIH Format Page Instructions

#let biosketch(
  name: "",
  eRA_commons: "",
  position: "",
  education: (),
  personal_statement: [],
  positions_honors: (),
  contributions: (),
  research_support: ()
) = {
  // Page setup for biosketch
  set page(
    paper: "us-letter",
    margin: (left: 0.5in, right: 0.5in, top: 0.5in, bottom: 0.5in),
  )

  set text(font: "IBM Plex Sans", size: 11pt)
  set par(justify: false, leading: 0.65em)

  // Header
  align(center)[
    #text(weight: "bold", size: 12pt)[BIOGRAPHICAL SKETCH]
  ]

  text(size: 10pt)[
    Provide the following information for the Senior/key personnel and other significant contributors. \
    Follow this format for each person. *DO NOT EXCEED FIVE PAGES.*
  ]

  line(length: 100%)

  // Name and position
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [*NAME:* #name],
    [*eRA COMMONS USER NAME:* #eRA_commons]
  )

  [*POSITION TITLE:* #position]

  line(length: 100%)

  // Education/Training
  heading(level: 1, numbering: none)[A. Personal Statement]
  personal_statement

  heading(level: 1, numbering: none)[B. Positions, Scientific Appointments, and Honors]

  heading(level: 2, numbering: none)[Positions and Scientific Appointments]
  for position in positions_honors.positions {
    [#position.years #h(2em) #position.title, #position.institution]
  }

  if positions_honors.honors != none {
    heading(level: 2, numbering: none)[Honors]
    for honor in positions_honors.honors {
      [#honor.year #h(2em) #honor.description]
    }
  }

  heading(level: 1, numbering: none)[C. Contributions to Science]

  for (i, contribution) in contributions.enumerate() {
    strong[#{i + 1}. #contribution.title]

    contribution.description

    for pub in contribution.publications {
      [#{pub.authors}. #{pub.title}. #{pub.journal}. #{pub.year};#{pub.details}.]
    }

    v(0.5em)
  }

  heading(level: 1, numbering: none)[D. Research Support]

  // Check if ongoing field exists and is not none
  if "ongoing" in research_support and research_support.ongoing != none {
    heading(level: 2, numbering: none)[Ongoing Research Support]
    for grant in research_support.ongoing {
      grid(
        columns: (auto, 1fr),
        gutter: 1em,
        [#grant.number],
        [#grant.pi #h(1em) (#grant.dates)]
      )
      [#grant.title]; linebreak()
      [#grant.role]; linebreak()
      [#grant.description]
      v(0.5em)
    }
  }

  // Check if completed field exists and is not none
  if "completed" in research_support and research_support.completed != none {
    heading(level: 2, numbering: none)[Completed Research Support]
    for grant in research_support.completed {
      grid(
        columns: (auto, 1fr),
        gutter: 1em,
        [#grant.number],
        [#grant.pi #h(1em) (#grant.dates)]
      )
      [#grant.title]; linebreak()
      [#grant.role]; linebreak()
      [#grant.description]
      v(0.5em)
    }
  }
}

// Define the biosketch example as a variable for importing
#let biosketch_example = biosketch(
  name: "Jane Smith, Ph.D.",
  eRA_commons: "JSMITH",
  position: "Professor of Neuroscience",
  personal_statement: [
    I have extensive expertise in cognitive neuroscience and neuroimaging, with a focus on
    executive function development in pediatric populations. My research has consistently
    been funded by NIH for the past 15 years, resulting in over 100 peer-reviewed publications.
    I am well-positioned to lead this project due to my unique combination of methodological
    expertise and clinical knowledge.
  ],
  positions_honors: (
    positions: (
      (years: "2018-present", title: "Professor", institution: "University Medical Center"),
      (years: "2012-2018", title: "Associate Professor", institution: "University Medical Center"),
      (years: "2006-2012", title: "Assistant Professor", institution: "State University"),
    ),
    honors: (
      (year: "2020", description: "Distinguished Investigator Award, Society for Neuroscience"),
      (year: "2018", description: "Presidential Early Career Award for Scientists and Engineers"),
    )
  ),
  contributions: (
    (
      title: "Neural mechanisms of cognitive control",
      description: [
        My early work established fundamental principles of how prefrontal cortex supports
        cognitive control in children. This work has been highly influential in the field.
      ],
      publications: (
        (
          authors: "Smith J, Johnson R, Williams S",
          title: "Developmental trajectories of cognitive control networks",
          journal: "J Cognitive Neurosci",
          year: "2023",
          details: "35(4):598-612"
        ),
      )
    ),
  ),
  research_support: (
    ongoing: (
      (
        number: "R01 MH123456",
        pi: "Smith (PI)",
        dates: "2021-2026",
        title: "Neural mechanisms of executive function in ADHD",
        role: "Principal Investigator",
        description: "This project investigates neural network dynamics in children with ADHD."
      ),
    ),
    completed: none
  )
)

// Actually render the biosketch example
#biosketch_example
