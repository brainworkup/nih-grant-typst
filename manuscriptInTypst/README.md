![Version](https://img.shields.io/static/v1?label=manuscriptInTypst&message=0.4&color=brightcolor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# First submission manuscript template in Typst

A nice introduction to Typst in October 2024 by Dr. Chase Brown of the University of Central Florida is found [here](https://mediasite.ouhsc.edu/Mediasite/Channel/python/browse/null/most-recent/null/0/null).


## Purpose

Prepare PDF for initial manuscript submission by using typst, a typesetting system written in Rust. Typst compiles small documents faster than LaTeX. This project has been developed enough to support the preparation of manuscripts of journal articles for the first submission. Its support for edge cases is underdeveloped.

## Features
- Barebones (i.e., no template file) for simplicity
- Two variants: classic and arvix-like.
- Line numbering
- Short author list, running title, and date printed in the header. This supports editing printed copies of multiple manuscripts while traveling.
- 1/N page numbering
- Biblatex (sorry, not support for BibTeX).
- example
  + figure
  + table
  + equation 

## Sample title page of classic variant

![ClassicTitle](https://github.com/user-attachments/assets/5f5e2da9-a764-4a19-8c9f-0dea23cc9298)

The footnote with the corresponding author's contact information is not shown.


## Sample Introduction page of classic variant

The abstract is on the second page.
The Introduction starts on the third page.
Note the short author list, running title, and today's date in the header.
Note the format of the page numbers in the lower right.

![ClassicIntroduction](https://github.com/user-attachments/assets/1f7bd37f-e2a4-4407-ac05-beaa75386b9e)




## Sample of first page of arvix-like variant


![arvix-like](https://github.com/user-attachments/assets/523f2054-25ec-4f05-8e47-58637fa97b07)


## Contents
- typst source file template
- BibLATeX file
- sample PDF


## Requirements

- typst version 0.12.0 (required for line numbers, released October 18, 2024) 

If you use tinymist, you will need the corresponding version, release October 19, 2024.

## Easy-peasy use

Run in typst.app on-line or run via tinymist (e.g., `tinymist preview classic.typ`) while classic.typ is open in any text editor.
The rendered version will appear in your default browser.
It updates with each save operation in the text editor.

Compile to PDF by entering in terminal `typst compile <typst filename prefix>.typ`.

## Bash or zsh function to compile and open in Preview.app on Mac (optional)

Typst compiles the *.typfile so quickly that you might as well pop open the PDF: `typc <filename prefix>`.

```bash
function typc {
echo "Compile typst file to PDF and display PDF file."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage1: typc <filename prefix>"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage1: typc  <typst filename prefix>"
  return 2
fi
typst compile $1.typ && pre $1.pdf
}
```

## Bash or zsh function to preview typst file with tinymist (optional)

Yes, I hate typing: `tmp <typst filename prefix>"

```bash
function tmp {
echo "Preview typst file in browser via tinymist."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage1: tmp <filename prefix>"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage1: typc  <filename prefix>"
  return 2
fi
tinymist preview $1.typ
}
```

## Bash or zsh function to project initiation (optional)

Paste into where ever you store your bash functions (.e.g., .bashrc or .bashFunctions sourced from .bashrc).
Customize the file paths to meet your needs.
Default to opening the classic variant. 
This is what most biology journals expect.
In computer science, use the arvix-like variant.

```bash
function typman {
echo "Copy template manuscript in typst with project number in title."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage1: typman projectID"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage1: typman projectID"
  return 2
fi
projectID="$1"
echo "Write manuscript to manu$1.typ file."
cp  ~/6112MooersLabGitHubLabRepos/manuscriptInTypst/classic-first-submission-manuscript.typ manu$1.typ
cp  ~/6112MooersLabGitHubLabRepos/manuscriptInTypst/first-submission.bib .
cp  ~/6112MooersLabGitHubLabRepos/manuscriptInTypst/words10.png .
}

function mantyp {
echo "Copy template writing manuscript in typst with project number in title."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage1: mantyp projectID"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage1: mantyp projectID"
  return 2
fi
projectID="$1"
echo "Write manuscript to manu$1.typ file."
cp  ~/6112MooersLabGitHubLabRepos/manuscriptInTypst/classic-first-submission-manuscript.typ manu$1.typ
cp  ~/6112MooersLabGitHubLabRepos/manuscriptInTypst/first-submission.bib .
cp  ~/6112MooersLabGitHubLabRepos/manuscriptInTypst/words10.png .
say 'The manuscript template has been copied.'
}
```

## Use in Emacs

Install the `typst-ts-mode` package beforehand.


## Update history

|Version       |Changes                                                                                               |Date                       |
|:-------------|:-----------------------------------------------------------------------------------------------------|:--------------------------|
| Version 0.1  | Initiate project. Added badges, funding, and update table.                                           | 2024 October 11           |
| Version 0.2  | Added bash function to ease initiating new manuscript in typst.                                      | 2024 October 13           |
| Version 0.3  | Added classic version.  Added date to running title. Centered title on title page                    | 2024 October 17           |
| Version 0.4  | Added two bash functions to README.md for convenience.                                               | 2024 October 19           |

## Sources of funding

- NIH: R01 CA242845
- NIH: R01 AI088011
- NIH: P30 CA225520 (PI: R. Mannel)
- NIH: P20 GM103640 and P30 GM145423 (PI: A. West)
