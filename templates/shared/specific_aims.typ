// Document setup for NIH grants
#set page(
  paper: "us-letter",
  margin: (left: 0.5in, right: 0.5in, top: 0.5in, bottom: 0.5in),
  numbering: "1",
  number-align: center,
)

// Font settings
#set text(font: "TeX Gyre Heros", size: 11pt)
#set par(justify: true, leading: 0.8em)

// Headings configuration
#set heading(numbering: none)
#show heading.where(level: 1): it => {
  set text(weight: "bold", size: 12pt)
  set block(above: 1.5em, below: 0.5em)
  it
}
#show heading.where(level: 2): it => {
  set text(weight: "bold", size: 11pt)
  set block(above: 1em, below: 0.5em)
  it
}

// Add the main heading
= SPECIFIC AIMS

// Define the content
#let specific_aims_example = [
  Cognitive control deficits are a core feature of many neurodevelopmental disorders, yet the
  underlying neural mechanisms remain poorly understood. This knowledge gap hampers the development
  of targeted interventions and biomarkers for early diagnosis. The goal of this research is to
  characterize the neural mechanisms of cognitive control across typical development and in
  neurodevelopmental disorders, specifically attention deficit hyperactivity disorder (ADHD) and
  autism spectrum disorder (ASD).

  We will pursue the following specific aims:

  == Aim 1: Characterize developmental trajectories of neural circuits supporting cognitive control

  *Hypothesis:* Cognitive control networks show protracted developmental trajectories that differ
  between typically developing children and those with ADHD or ASD.

  We will use multimodal neuroimaging (fMRI-EEG) to map developmental changes in neural activation
  and connectivity during cognitive control tasks across ages 7-18 years in all three groups.

  == Aim 2: Identify disorder-specific neural signatures of cognitive control deficits

  *Hypothesis:* ADHD and ASD are associated with distinct patterns of neural dysfunction during
  cognitive control tasks, despite behavioral similarities.

  We will apply machine learning techniques to identify disorder-specific neural signatures that
  differentiate ADHD and ASD from typical development and from each other.

  == Aim 3: Determine the relationship between neural network dynamics and individual differences in cognitive control abilities

  *Hypothesis:* Individual differences in cognitive control abilities are better predicted by
  neural network dynamics than by diagnostic category.

  We will use computational modeling to characterize the relationship between neural network
  dynamics and performance on cognitive control tasks, accounting for both within- and
  between-group variability.

  This research will significantly advance our understanding of the neural basis of cognitive
  control in typical and atypical development, with implications for the development of
  personalized interventions and objective biomarkers for neurodevelopmental disorders.
]

// Actually render the content
#specific_aims_example
