# TEXSAVE: save dataset in LaTeX format.

- Current version: `1.6.2 23sep2023`
- Jump to:  [`overview`](#overview) [`installation`](#Installation) [`update history`](#update-history)  [`author`](#author)

-----------


## Overview: 

`texsave` is a Stata command that outputs the dataset currently in memory to a file in LaTeX format. It uses the `booktabs`, `tabularx`, and `geometry` LaTeX packages to produce publication-quality tables. The syntax is described in the Stata help file included in this package.

Julian Reif's [Stata Coding Guide](https://reifjulian.github.io/guide/#automating_tables) provides a tutorial.

## Installation:

Type `which texsave` at the Stata prompt to determine which version you have installed. To install the most recent version, copy and paste the following line of code:

```
net install texsave, from("https://raw.githubusercontent.com/reifjulian/texsave/master") replace
```

To install the version that was uploaded to SSC, copy and paste the following line of code:
```
ssc install texsave, replace
```

After installing, type `help texsave` to learn the syntax.


## Update History:
* **Septembe r23, 2023**
  - Fixed bug affecting long variable names

* **May 22, 2023**
  - Added `rowstretch()`, `rowheight()`, `colwidth()`, and `tablelines()` options
  - Added `headerlines2()` option
  - Added 'R' and 'L' options to `align()`

* **November 30, 2022**
  - Added `@{}` to header alignment
  - Changed footnote to use `\parbox`

* **January 3, 2022**
  - Added `dataonly` option, which outputs only content of the table (no variable names, footnotes, etc.)
  - Updated `endash` option to work with multiple negative values

* **November 2, 2020**
  - Added support for aligning numeric values at the decimal point using the `siunitx` package

* **July 1, 2020**
  - `texsave` now outputs en dash's instead of hyphens for negative numbers. Specifying `noendash` restores previous behavior.

* **December 11, 2019**
  - Added `headersep()` option, with new default: `\addlinespace[\belowrulesep]`

* **January 17, 2019**
  - Added `preamble()` option

## Author:

[Julian Reif](http://www.julianreif.com)
<br>University of Illinois
<br>jreif@illinois.edu
