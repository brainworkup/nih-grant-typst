#set page(
  paper: "us-letter",
  margin: (left: 0.5in, right: 0.5in, top: 0.5in, bottom: 0.5in),
  numbering: "1",
  number-align: center,
)

#set text(font: "Arial", size: 11pt)
#set par(justify: true, leading: 0.8em)

// Configure heading styles
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

#let budget_example = [
  This five-year R01 project requires the following resources to accomplish the proposed aims:

  == PERSONNEL

  *Principal Investigator (Dr. Jane Smith, 25% effort):* Dr. Smith will provide overall scientific
  leadership for the project, oversee all aspects of study design, data collection, analysis, and
  dissemination. She will supervise research staff and ensure adherence to timelines and research
  protocols.

  *Co-Investigator (Dr. Robert Johnson, 15% effort):* Dr. Johnson will contribute expertise in
  neuroimaging methods and analysis, assist with fMRI protocol development, and supervise the
  neuroimaging data processing pipeline.

  *Co-Investigator (Dr. Sarah Williams, 10% effort):* Dr. Williams will contribute expertise in
  developmental psychopathology, assist with clinical assessments, and help interpret findings in
  the context of neurodevelopmental disorders.

  *Postdoctoral Researchers (2 FTE):* Two postdoctoral researchers will coordinate data collection,
  implement preprocessing and analysis pipelines, conduct statistical analyses, and prepare
  manuscripts and presentations.

  *Research Assistants (2 FTE):* Two research assistants will recruit and schedule participants,
  administer cognitive and clinical assessments, assist with neuroimaging data collection, and
  manage research databases.

  *MRI Technician (25% effort):* A certified MRI technician will operate the MRI scanner during
  data collection and ensure high-quality neuroimaging data.

  == EQUIPMENT

  *EEG System Upgrade (\$75,000, Year 1 only):* Funds are requested to upgrade the existing EEG
  system to enable simultaneous fMRI-EEG recording. This includes MRI-compatible caps, amplifiers,
  and software.

  *Computing Cluster Expansion (\$50,000, Year 1 only):* Additional computing nodes are needed for
  the intensive computational modeling and machine learning analyses proposed in Aims 2 and 3.

  == SUPPLIES

  *Neuroimaging Supplies (\$15,000/year):* Includes MRI-compatible response devices, head cushions,
  disposable EEG electrodes, and participant monitoring equipment.

  *Computing Supplies (\$10,000/year):* Storage media, backup systems, software licenses, and
  computing peripherals.

  *Office Supplies (\$5,000/year):* General office supplies, printing costs for assessment materials,
  and participant recruitment materials.

  == TRAVEL

  *Conference Travel (\$15,000/year):* Funds for PI, co-investigators, and postdocs to attend and
  present at 2-3 major conferences per year (e.g., Organization for Human Brain Mapping, Society
  for Neuroscience, Cognitive Neuroscience Society).

  *Collaboration Travel (\$5,000/year):* Travel for PI and key personnel to meet with collaborators
  for specialized training and data analysis.

  == PARTICIPANT COSTS

  *Participant Compensation (\$60,000/year):* Compensation for 180 participants (60 per group) at
  \$250 per participant for approximately 6 hours of testing (includes neuroimaging, cognitive
  assessments, and clinical interviews) plus travel expenses. Additional funds for follow-up
  testing in years 3-5.

  *Participant Recruitment (\$10,000/year):* Advertising costs, community outreach materials, and
  screening expenses.

  == OTHER DIRECT COSTS

  *MRI Scanner Time (\$120,000/year):* 300 hours of scanner time per year at \$400/hour for
  participant scanning and pilot testing.

  *Publication Costs (\$10,000/year):* Open access publication fees for approximately 4-5
  manuscripts per year.

  *Research Computing Services (\$15,000/year):* High-performance computing resources and technical
  support for computational modeling and large-scale data analysis.

  == BUDGET JUSTIFICATION SUMMARY

  The requested budget is appropriate and necessary to complete the proposed research. Personnel
  costs reflect the interdisciplinary expertise required for this complex project involving
  clinical populations, advanced neuroimaging methods, and sophisticated computational analyses.
  Equipment costs are essential for the simultaneous fMRI-EEG recording central to our approach.
  Participant costs reflect the comprehensive assessments and the need to adequately compensate
  families for their substantial time commitment. Neuroimaging costs are based on current rates at
  our institution's imaging center. This budget has been carefully planned to ensure the most
  efficient use of resources while enabling the successful completion of all aims.
]

// To display the budget example
#budget_example



// #let budget_example = [
//   This five-year R01 project requires the following resources to accomplish the proposed aims:

//   #heading(level: 2, [PERSONNEL])

//   *Principal Investigator (Dr. Jane Smith, 25% effort):* Dr. Smith will provide overall scientific
//   leadership for the project, oversee all aspects of study design, data collection, analysis, and
//   dissemination. She will supervise research staff and ensure adherence to timelines and research
//   protocols.

//   *Co-Investigator (Dr. Robert Johnson, 15% effort):* Dr. Johnson will contribute expertise in
//   neuroimaging methods and analysis, assist with fMRI protocol development, and supervise the
//   neuroimaging data processing pipeline.

//   *Co-Investigator (Dr. Sarah Williams, 10% effort):* Dr. Williams will contribute expertise in
//   developmental psychopathology, assist with clinical assessments, and help interpret findings in
//   the context of neurodevelopmental disorders.

//   *Postdoctoral Researchers (2 FTE):* Two postdoctoral researchers will coordinate data collection,
//   implement preprocessing and analysis pipelines, conduct statistical analyses, and prepare
//   manuscripts and presentations.

//   *Research Assistants (2 FTE):* Two research assistants will recruit and schedule participants,
//   administer cognitive and clinical assessments, assist with neuroimaging data collection, and
//   manage research databases.

//   *MRI Technician (25% effort):* A certified MRI technician will operate the MRI scanner during
//   data collection and ensure high-quality neuroimaging data.

//   #heading(level: 2, [EQUIPMENT])

//   *EEG System Upgrade (\$75,000, Year 1 only):* Funds are requested to upgrade the existing EEG
//   system to enable simultaneous fMRI-EEG recording. This includes MRI-compatible caps, amplifiers,
//   and software.

//   *Computing Cluster Expansion (\$50,000, Year 1 only):* Additional computing nodes are needed for
//   the intensive computational modeling and machine learning analyses proposed in Aims 2 and 3.

//   #heading(level: 2, [SUPPLIES])

//   *Neuroimaging Supplies (\$15,000/year):* Includes MRI-compatible response devices, head cushions,
//   disposable EEG electrodes, and participant monitoring equipment.

//   *Computing Supplies (\$10,000/year):* Storage media, backup systems, software licenses, and
//   computing peripherals.

//   *Office Supplies (\$5,000/year):* General office supplies, printing costs for assessment materials,
//   and participant recruitment materials.

//   #heading(level: 2, [TRAVEL])

//   *Conference Travel (\$15,000/year):* Funds for PI, co-investigators, and postdocs to attend and
//   present at 2-3 major conferences per year (e.g., Organization for Human Brain Mapping, Society
//   for Neuroscience, Cognitive Neuroscience Society).

//   *Collaboration Travel (\$5,000/year):* Travel for PI and key personnel to meet with collaborators
//   for specialized training and data analysis.

//   #heading(level: 2, [PARTICIPANT COSTS])

//   *Participant Compensation (\$60,000/year):* Compensation for 180 participants (60 per group) at
//   \$250 per participant for approximately 6 hours of testing (includes neuroimaging, cognitive
//   assessments, and clinical interviews) plus travel expenses. Additional funds for follow-up
//   testing in years 3-5.

//   *Participant Recruitment (\$10,000/year):* Advertising costs, community outreach materials, and
//   screening expenses.

//   #heading(level: 2, [OTHER DIRECT COSTS])

//   *MRI Scanner Time (\$120,000/year):* 300 hours of scanner time per year at \$400/hour for
//   participant scanning and pilot testing.

//   *Publication Costs (\$10,000/year):* Open access publication fees for approximately 4-5
//   manuscripts per year.

//   *Research Computing Services (\$15,000/year):* High-performance computing resources and technical
//   support for computational modeling and large-scale data analysis.

//   #heading(level: 2, [BUDGET JUSTIFICATION SUMMARY])

//   The requested budget is appropriate and necessary to complete the proposed research. Personnel
//   costs reflect the interdisciplinary expertise required for this complex project involving
//   clinical populations, advanced neuroimaging methods, and sophisticated computational analyses.
//   Equipment costs are essential for the simultaneous fMRI-EEG recording central to our approach.
//   Participant costs reflect the comprehensive assessments and the need to adequately compensate
//   families for their substantial time commitment. Neuroimaging costs are based on current rates at
//   our institution's imaging center. This budget has been carefully planned to ensure the most
//   efficient use of resources while enabling the successful completion of all aims.
// ]
