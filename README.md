# TEXSAVE: save dataset in LaTeX format.

- Current version: `1.4.5 1jul2020`
- Jump to: [`updates`](#recent-updates) [`install`](#install) [`description`](#description) [`author`](#author)

-----------

## Updates:

* **July 1, 2020**
  - `texsave` now ouputs en dash's instead of hyphens for negative numbers. Specifying `noendash` restores previous behavior.

* **December 11, 2019**
  - Added `headersep()` option, with new default: `\addlinespace[\belowrulesep]`

* **January 17, 2019**
  - Added `preamble()` option

## Install:

Type `which texsave` at the Stata prompt to determine which version you have installed. To install the most recent version of `texsave`, copy/paste the following line of code:

```
net install texsave, from("https://raw.githubusercontent.com/reifjulian/texsave/master") replace
```

To install the version that was uploaded to SSC, copy/paste the following line of code:
```
ssc install texsave, replace
```

These two versions are typically synced, but occasionally the SSC version may be slightly out of date.

## Description: 

`texsave` is a [Stata](http://www.stata.com) command that outputs the dataset currently in memory to a file in LaTeX format. It uses the LaTeX packages *booktabs*, *tabularx*, and *geometry* to produce publication-quality tables.

For more details, see the Stata help file included in this package.

## Author:

[Julian Reif](http://www.julianreif.com)
<br>University of Illinois
<br>jreif@illinois.edu
