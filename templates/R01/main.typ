#import "config.typ": *
#import "../common/nih-functions.typ": *

#show: nih-document.with(
  grant-type: "R01",
  pi-name: "[PI Name]",
  institution: "[Institution]",
  project-title: "[Project Title]"
)

#include "sections/abstract.typ"
#include "sections/specific-aims.typ"
#include "sections/significance.typ"
#include "sections/innovation.typ"
#include "sections/approach.typ"
#include "sections/bibliography.typ"
