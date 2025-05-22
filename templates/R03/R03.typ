#import "config.typ": *
#import "../shared/specific_aims.typ": specific_aims_example
#import "../shared/budget.typ": budget_example

// Main document structure using the config template
#show: nih-grant.with(
  title: "Development of Novel Biomarkers for Early Detection of Executive Function Deficits",
  pi: "Dr. Jane Smith",
  institution: "University Medical Center"
)

// Specific Aims Section - Note that R03 grants have more limited scope than R01s
#specific_aims[
  The overarching goal of this R03 small research project is to develop and validate novel
  biomarkers for the early detection of executive function deficits in children aged 5-7 years.
  This project will leverage existing neuroimaging and behavioral data from the Cognitive
  Development Study to identify neural signatures that predict later development of cognitive
  control difficulties.

  #v(0.5em)

  *Specific Aim 1:* Identify candidate neural biomarkers associated with executive function
  performance in young children.
  We will analyze existing fMRI data from 120 children who completed a child-friendly executive
  function task battery at ages 5-7. Using machine learning approaches, we will extract neural
  features that are most predictive of concurrent performance on standardized executive
  function measures.

  #v(0.5em)

  *Specific Aim 2:* Validate the predictive utility of identified biomarkers for future
  executive function outcomes.
  We will test whether the neural signatures identified in Aim 1 predict executive function
  performance and real-world outcomes (academic achievement, behavioral regulation) at 2-year
  follow-up assessments.

  #v(0.5em)

  *Impact:* This R03 project will deliver a set of validated neural biomarkers with potential
  for early identification of children at risk for executive function difficulties. These
  findings will form the foundation for a future R01 application focused on developing and
  testing targeted early interventions for these at-risk children.
]

// Research Strategy Section
#research_strategy(
  // Significance
  [
    Executive function deficits are implicated in multiple neurodevelopmental disorders and
    predict academic and behavioral difficulties. However, reliable early detection remains
    challenging, as these skills develop rapidly during early childhood and standard behavioral
    assessments often lack sensitivity in young children. Identifying objective neural biomarkers
    could enable earlier and more precise identification of children who would benefit from
    intervention.

    This project addresses a significant gap in developmental cognitive neuroscience by
    leveraging an existing, well-characterized dataset to develop biomarkers that can be
    applied in future research and clinical settings. The project's focus on ages 5-7 years
    is strategic, as this represents a critical period of executive function development and
    a time when early intervention may be most effective.
  ],

  // Innovation
  [
    This R03 project is innovative in several ways:

    1. It repurposes existing neuroimaging data from a developmental cohort to answer new
       questions about biomarkers of executive function, maximizing the scientific yield from
       prior research investments.

    2. It employs advanced machine learning techniques specifically optimized for pediatric
       neuroimaging data, addressing unique challenges such as higher motion artifacts and
       developmental variability.

    3. It focuses on biomarker development at ages 5-7, earlier than most existing research,
       creating opportunities for earlier identification and intervention.
  ],

  // Approach
  [
    *Data Source:* We will utilize existing data from the Cognitive Development Study, which
    includes structural and functional MRI, diffusion tensor imaging, and comprehensive
    neurocognitive assessments from 120 children (ages 5-7 at baseline) with 2-year follow-up
    data available.

    *Aim 1 Methods:* We will extract features from task-based fMRI during three executive
    function tasks (inhibitory control, working memory, cognitive flexibility). Features will
    include activation patterns, connectivity metrics, and network properties. We will apply
    elastic net regression and random forest algorithms to identify the neural features most
    predictive of concurrent executive function performance.

    *Aim 2 Methods:* We will test whether the biomarkers identified in Aim 1 predict executive
    function performance and real-world outcomes at the 2-year follow-up. We will use multiple
    regression models controlling for age, sex, socioeconomic status, and baseline performance.

    *Statistical Power:* Based on prior work, our sample size of 120 provides >80% power to
    detect medium effect sizes (r = 0.25) at α = 0.05 after correction for multiple comparisons.

    *Timeline:* This project is designed for completion within the 2-year R03 timeframe, with
    Year 1 dedicated to Aim 1 analyses and Year 2 focused on Aim 2 validation and preparation
    of manuscripts and the subsequent R01 application.
  ]
)

// Bibliography
#references("references.bib")

// Budget Section - Note that R03 grants have a smaller budget than R01s
#heading(level: 1, [BUDGET & JUSTIFICATION])
#budget_example
