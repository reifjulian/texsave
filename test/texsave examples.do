* Run several examples
set more off
adopath ++ "../src"
version 10.1

* 1. Output a table with a title and a footnote.

   sysuse auto.dta, clear
   texsave make mpg trunk if price > 8000 using "example1.tex", title(MPG and trunk space) footnote(Variable trunk measured in cubic feet) replace

   * Can we output varnames with "_" in them?
   sysuse auto.dta, clear
   texsave make mpg gear_ratio if price > 8000 using "example1_1.tex", title(MPG and trunk space) footnote(Variable trunk measured in cubic feet) replace

   
* 2. Output a table with a small font size and some horizontal lines.

   sysuse auto.dta, clear
   cap texsave make mpg trunk weight length displacement turn  using "example2.tex" in 1/30, size(2) hlines(3 10/13 19 23 25 31) replace
   assert _rc==198
   cap texsave make mpg trunk weight length displacement turn  using "example2.tex" in 1/30, size(2) hlines(3 10/13 19 23 25 -31) replace
   assert _rc==198
   texsave make mpg trunk weight length displacement turn using "example2.tex" in 1/30, size(2) hlines(3 10/13 19 23 25 -2 30) replace


* 3. Output a table with non-variable name headers and LaTeX math code in the footnote.

   sysuse auto.dta, clear
   label var make "Car make"
   label var mpg "Miles per gallon"
   label var trunk "Trunk space"
   texsave make mpg trunk if price > 8000 using "example3.tex", title(MPG and trunk space) varlabels footnote("Variable trunk measured in ft\(^3\)") nofix replace

* 4. Output a table with additional LaTeX code.

   sysuse auto.dta, clear
   texsave make mpg trunk if price > 8000 using "example4.tex", loc(h) preamble("\usepackage{amsfonts}") headlines("\begin{center}" "My headline" "\end{center}") footlines("My footline") replace

* 5. Headerlines
	sysuse auto, clear
	texsave make mpg trunk if price > 8000 using "example5.tex", bold("Buick") headerlines("& \multicolumn{2}{c}{\textbf{Data}}" "\cmidrule{2-3}\addlinespace[-2ex]") replace nofix
	
* 6. Do some bolding, italicizing, and underlining
	sysuse auto.dta, clear
	texsave make mpg trunk if price > 8000 using "example6.tex", slanted("Deville") smallcaps("Continental") sansserif("Mark") monospace("Datsun") emphasis("Volvo") bold("Buick") underline("Buick" "Olds") italics("Eldorado") replace
	
	* Regsave example
	sysuse auto.dta, clear
	regress price mpg trunk
	regsave using results, table(reg1, order(regvars r2) format(%5.1f) parentheses(stderr) asterisk(10 5)) replace
	regress price mpg trunk headroom
	regsave using results, table(reg2, order(regvars r2) format(%5.1f) parentheses(stderr) asterisk(10 5)) append
	regress price mpg trunk headroom length
	regsave using results, table(reg3, order(regvars r2) format(%5.1f) parentheses(stderr) asterisk(10 5)) append

	use results, clear
	drop if strpos(var,"_cons")!=0
	replace var = subinstr(var,"_coef","",.)
	replace var = "" if strpos(var,"_stderr")!=0
	replace var = "R-squared" if var == "r2"
	replace var = "Observations" if var=="N"
	rename var Regressor
	
	texsave using "regsave example1.tex", title(Regression results) footnote("A */** next to the coefficient indicates significance at the 10/5% level") autonumber hlines(8) nonames replace
	
	label var reg1 "Regression 1"
	label var reg2 "Regression 2"
	label var reg3 "Regression 3"
	texsave using "regsave example2.tex", title(Regression results) footnote("A */** next to the coefficient indicates significance at the 10/5% level") varlabels autonumber hlines(8) replace
	cap texsave using "regsave example2.tex", title(Regression results) footnote("A */** next to the coefficient indicates significance at the 10/5% level") varlabels nonames hlines(8) replace
	assert _rc==198
	
* 7. Landscape option
	
	sysuse auto, clear
	texsave using "example7.tex" if price>5000, title("Auto dataset") landscape geometry(left=.2in,right=.2in) size(scriptsize) replace
	
* 8. Rowsep option
	sysuse auto, clear
	texsave using "example8.tex" if price>5000, title("Auto dataset") rowsep(0.1cm) size(scriptsize) replace
	
* 9. Footnote align option
	sysuse auto, clear
	local fn "This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote."
	texsave make mpg trunk weight length displacement turn using "example9.1.tex" if price>5000, title("Auto dataset") size(scriptsize) replace footnote("`fn'")
	texsave make mpg trunk weight length displacement turn using "example9.2.tex" if price>5000, title("Auto dataset") size(scriptsize) replace footnote("`fn'", width("p{16cm}"))
	

** EOF
