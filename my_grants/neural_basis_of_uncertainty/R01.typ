#import "config.typ": *
#import "../shared/specific_aims.typ": specific_aims_example
#import "../shared/budget.typ": budget_example

// Main document structure using the config template
#show: nih-grant.with(
  title: "Understanding Neural Mechanisms of Cognitive Control in Neurodevelopmental Disorders",
  pi: "Dr. Joey Trampush",
  institution: "USC Keck"
)

// Specific Aims Section
#specific_aims[
  #specific_aims_example
]

// Research Strategy Section
#research_strategy(
  // Significance
  [
    Despite significant advances in understanding the neural basis of cognitive control,
    there remains a critical gap in our knowledge of how these processes develop and function
    in individuals with neurodevelopmental disorders. This project addresses this gap by
    investigating the neural mechanisms underlying cognitive control processes in three
    distinct populations: typically developing children, children with attention deficit
    hyperactivity disorder (ADHD), and children with autism spectrum disorder (ASD).

    Our preliminary data indicate significant differences in neural activation patterns
    during cognitive control tasks between these groups, suggesting distinct
    neurodevelopmental trajectories that may inform targeted interventions.
  ],

  // Innovation
  [
    This proposal is innovative in several ways:

    1. It employs a novel multimodal neuroimaging approach combining functional magnetic
       resonance imaging (fMRI) with electroencephalography (EEG) to capture both the spatial
       and temporal dynamics of neural activity during cognitive control tasks.

    2. It utilizes advanced computational modeling techniques to characterize individual
       differences in neural network dynamics, moving beyond group-level analyses to capture
       heterogeneity within diagnostic categories.

    3. It incorporates a developmental perspective by examining age-related changes in
       cognitive control networks across a wide age range (7-18 years), allowing for the
       identification of critical periods for intervention.
  ],

  // Approach
  [
    *Participants:* We will recruit 60 typically developing children, 60 children with ADHD,
    and 60 children with ASD, aged 7-18 years. Groups will be matched on age, sex, and IQ.
    All participants will undergo comprehensive clinical assessment.

    *Procedures:* Participants will complete a battery of cognitive control tasks during
    simultaneous fMRI-EEG recording. Tasks include the Stop Signal Task, Flanker Task, and
    Task-Switching paradigm, all adapted for the developmental population.

    *Analysis:* We will employ both traditional univariate analyses and advanced multivariate
    pattern analysis to identify neural signatures of cognitive control. Dynamic causal
    modeling will be used to characterize effective connectivity between brain regions.
    Machine learning approaches will be applied to predict individual differences in
    cognitive control abilities from neural data.

    *Expected Outcomes:* This research will yield a comprehensive understanding of the neural
    mechanisms underlying cognitive control in typical development and neurodevelopmental
    disorders. Findings will inform the development of targeted interventions and contribute
    to the identification of biomarkers for early diagnosis and treatment monitoring.
  ]
)

// Bibliography
#references("references.bib")

// Budget Section
#heading(level: 1, [BUDGET & JUSTIFICATION])
#budget_example
