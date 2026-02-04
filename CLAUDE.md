# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

texsave is a Stata command that exports the current dataset to a LaTeX format file. It generates publication-quality tables using the `booktabs`, `tabularx`, and `geometry` LaTeX packages.

## Repository Structure

- `src/` - Source files
  - `texsave.ado` - Main command implementation
  - `texsave.sthlp` - Stata help file
  - `appendfile.ado` - Helper utility for file concatenation
- `test/` - Test suite
- `stata.toc` and `texsave.pkg` - Stata package installation files

## Running Tests

Tests are in `test/texsave_tests.do`. Run from the test directory:

```bash
powershell.exe -Command "Start-Process -FilePath 'C:\Program Files\Stata19\StataMP-64.exe' -ArgumentList '/e do texsave_tests.do' -WorkingDirectory 'C:\Users\jreif\Documents\GitHub\texsave\test' -Wait -NoNewWindow"
```

Output is written to `test/texsave_tests.log`.

## Architecture Notes

### texsave.ado

The main program flow:
1. **Option parsing and validation** (lines 31-200): Parses syntax, validates options like `hlines()`, `location()`, `size()`, and processes footnote suboptions
2. **Header construction** (lines 219-288): Builds column headers from variable names/labels, handles `autonumber`, `headerlines()`, and applies the `fix` option to escape LaTeX special characters
3. **Data transformation** (lines 294-371): Creates temporary variables to apply formatting (bold, italics, etc.), escape special characters, and convert hyphens to en-dashes for negative numbers
4. **LaTeX output generation**:
   - Writes preamble and document structure (lines 386-466)
   - Exports data via Stata's `outsheet`, then uses `filefilter` to add `\tabularnewline` line endings (lines 474-521)
   - Writes table footer with optional footnotes (lines 528-557)
   - Concatenates all parts using `appendfile` (lines 563-567)

### Key Implementation Details

- The `fix` option (enabled by default) escapes LaTeX special characters: `_ % # $ & ~ ^ { }`
- Negative numbers are converted to en-dashes by default (disable with `noendash`)
- The `decimalalign` option uses the `siunitx` package for decimal alignment
- Original variables are preserved by creating temporary copies for transformation
