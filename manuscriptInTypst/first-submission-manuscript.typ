// Created 2024-09-29 Sun 23:01
// Intended Typst compiler

#set page(width: 8.5in, height: 11in, margin: (x: 0.5in, y: 0.5in),)
#set text(11pt)
#set text(font: "Helvetica")

// Requires typst  version 0.12.0 for line numbering.
#set par.line(numbering: "1")
#show figure: set par.line(numbering: none)

// Set the title use for reuse in the running title and the main title page.
#let title = [Template for manuscript preparation with typst]
#let running = [Arvix-like template #datetime.today().display()]

// I have yet to figure out how to put the short author list on the left.
#set page(
     header:[ Student, ..., and Mooers #h(1fr) #running],
  numbering: "1 / 1",
  number-align: right,
)


#align(center, text(17pt)[
  *#title*
])


#grid(
  columns: (1fr, 1fr),
  align(center)[
    Nobel Prizer Winner \
    Well-funded Institute \
    #link("mailto:hotshot@wellfunded.edu")
  ],
  align(center)[
    Dr. Blaine Mooers \
    OUHS \
    #link("mailto:blaine-mooers@ouhsc.edu")
  ]
)

#align(center, text(11pt)[#datetime.today().display()])

#set par(justify: true)

= Abstract
 
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.
Fill in after the results section is filled in.


*Keywords:* typesetting, typography, scientific writing, reproducible research, text editing, collaborative writing, version control


#set par(leading: 2em, justify: false)

= Introduction
Typst is a new markup language for writing various kinds of documents, such as PDF and HTML.
It is meant to be a rethink of LaTeX, although the heavy influence of LaTeX in the typing of math equations suggests otherwise.
It takes a computer programmer approach to typesetting by providing functions to act on some or all of the text.
Many of these functions can be stored in an external template file that is imported into a given typst manuscript file so the clustter of these functions can remain out of sight to give the main typst document less cluttered appearance.
The typst project is still in development  and is not yet complete, but the project' repository on GitHub has attracted over 33,100 stars.
The tinymist program supports live previews of the document in the web browser, so any editor can be used to edit typst documents while enjoying previews of the PDF.
The typst project is complete enough to support the generation of the first-submission version of a manuscript as a PDF, although it may be years before publishers will accept typst source files. \ \

The biggest snag to getting going with typst for writing is the need for the bibliography to be in the typst native format (hayagriva) or in BibLaTeX.
The JabRef program supports conversions of BibTeX entries to BibLaTeX.

The second program is that there are breaking changes in the main program.
Some packages are already broken because the maintainers lost interest.


= Materials and methods

== First set of methods


== Second set of methods



= Results

I insert an overview of the results section here let the reader know what is comming.
No one has ever complained about this paragraphy although most authors skip it.

== Hot result number one


Tables have to be wrapped in a figure function (see @progress) to add a caption.
I put the label at the end of the caption.
Tables are numbered separately from figures.
You do not have to take any special measures.
You may have to move the table to the back of the paper, depending on the author guidelines.

#figure(
 table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Milestone*], [*Traget date*], [*Achievement data*],),
    [milestone 1], [date], [date],
    [milestone 2], [date], [date],
    [milestone 3], [date], [date]
 ),
    caption: [Milestones and dates.]
)<progress>


== Hot result number two

With regard to figures (see @words), typst does not handle PDF nor Tiff.
You have to convert them to SVG or to one of the bitmap formats:  PNG, GIF, or JPG.
Note the absence of support of postscript or encapsulated postscript.
Many journals accept these only these latter formats for the final submission.
Be prepared to make your figures in multiple formats.


#figure(
  image("words10.png", width: 80%),
  caption: [A curious figure.],
)<words>


== Hot result number three

Equations can be numbered and shown in display mode (@ratio).
The math equation fuction allows you to control the placement of the equation number.

#set math.equation(numbering: "(1)")

$ phi.alt = (1 + sqrt(5)) / 2 $ <ratio>

Can we add a caption to the equation by wrapping it in a figure @bragg? Not really. It is called a figure when it is an equation.


#figure(
    $ 2 upright(d) sin theta = upright(n) lambda $,
    caption: [Caption of the equation.],
)<bragg>


== Hot result number four



== Hot result number five



== Hot result number six





= Discussion



== Typst vs. LaTeX

It is useful to compare and contrast typst with LaTeX because typst was developed as an alternative to LaTeX.
Many of the claims of ease of use in favor of typst are over-stated.
It is clearly more capable than Common Markdown, but it is far less capable than LaTeX.
It might meet the demands of users unwilling, or not ready, to do the work of learning LaTeX who are dissatisfied with markdown.
I learned a series of markup languages and experienced repeated disaapointments with their shortcomings: Then I gave in and learned LaTeX. \ \

The phrase ``tpyst makes LaTeX great again'' comes to mind: typst has inspired me to dig deeper into LaTeX.
LaTeX users may want to learn typst to rekindle their love for LaTeX.
Org-mode users may want to learn typst for similar reasons. \ \

== Acceptance by publishers

Publishers should accept PDFs of first submission manuscirpts written in typst.
Some skilled typst users have already prepared templates for several journals.
One is available for MDPI journals. \ \


== Suitability for version control

The practice is writing one sentence per line is consistent with version control.
Typst accommodates this unorthodox approach to writing sentences. \ \

The wrapping of sentences into paragraphs in a source document is mark of insanity.
You will have to unwrap your sentences to be able to shuffle them around during rewriting.

I think that the wrapping of sentences into block paragraphs was driven by the need to save paper.
It is not necessary in electronic formats. \ \

Some claim that the format of one sentence per line reduces comprehension.
I doubt this is true: It more likely that reading comprehension is improved. \ \


== Support for collaborative editing

The typst.app has promised to support collaborative writing in a fashion similar to Oveleaf.
The developers even have an underleaf project based on typst.
I have a latency issue with this app when my computer is running low on RAM. \ \


== Voice computing with typst

You should be able to use speech-to-text via the Google plug-in Voice In. \ \


== Text editor support

I prefer to work local in Emacs @Mooers2021Templates.
I use the typst-ts-mode with treemacs.
I am still working on the live preview in Emacs. \ \






= Acknowledgments

We thank Chase Brown for introducing us to typst.


= Funding





#set par(leading: 0.5em, justify: false)
#bibliography("first-submission.bib",
                title: "Cited References",
                style: "cell")



// Local Variables:
// tp--master-file: "/Users/blaine/6112MooersLabGitHubLabRepos/manuscriptInTypst/first-submission-manuscirpt.typ"
// End:
