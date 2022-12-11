cscript texsave adofile texsave

clear
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
	texsave using "regsave example2.tex", title(Regression results) footnote("A */** next to the coefficient indicates significance at the 10/5% level") varlabels autonumber hlines(8) headersep(2ex) replace
	cap texsave using "regsave example2.tex", title(Regression results) footnote("A */** next to the coefficient indicates significance at the 10/5% level") varlabels nonames hlines(8) replace
	assert _rc==198
	
* 7. Landscape option
	
	sysuse auto, clear
	local fn : di _dup(40) "Duplicated string "
	texsave using "example7.tex" if price>5000, title("Auto dataset") landscape geometry(left=.2in,right=.2in) size(scriptsize) footnote("Notes: `fn'") replace
	
* 8. Rowsep option
	sysuse auto, clear
	texsave using "example8.tex" if price>5000, title("Auto dataset") rowsep(0.1cm) size(scriptsize) replace
	
* 9. Footnote align option
	sysuse auto, clear
	local fn "This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote. This is a looooooooooooooooong fooooooooootnote."
	texsave make mpg trunk weight length displacement turn using "example9.1.tex" if price>5000, title("Auto dataset") size(scriptsize) replace footnote("`fn'")
	texsave make mpg trunk weight length displacement turn using "example9.2.tex" if price>5000, title("Auto dataset") size(scriptsize) replace footnote("`fn'", width("16cm"))

* 10. Fix option
	sysuse auto, clear
	gen number = string(headroom)
	replace number = string(headroom*-1) if mpg>15
	replace number = "[" + number + "]" if mod(_n,5)==0
	replace number = "(" + number + ")" if mod(_n,5)==2
	replace number = "(" + number + "**" if mod(_n,5)==3
	replace number = "x-4g" in 11
	
	gen string = "var_1" in 1
	replace string = "var%2" in 2
	replace string = "var#3" in 3
	replace string = "var$4" in 4
	replace string = "var&5" in 5
	replace string = "var~6" in 6
	replace string = "var^6" in 7
	
	
	texsave make number string using "example10.1.tex" if _n<30, title("title_%#&") replace footnote("fn_%#&")
	texsave make number string using "example10.2.tex" if _n<30, title("title_%#&") replace footnote("fn_%#&") noendash

* 11. New label option
  sysuse auto, clear
  cap texsave using "example11.tex" if price>6000, landscape title("My autos") replace marker(my autos) label(my)
  assert _rc==198
  texsave using "example11a.tex" if price>6000, landscape title("My autos") replace marker(my autos)
  texsave using "example11b.tex" if price>6000, landscape title("My autos") replace label(my autos)

  * 12. New dataonly option
   sysuse auto.dta, clear
   texsave make mpg trunk if price > 8000 using "example12.tex", title(MPG and trunk space) footnote(Variable trunk measured in cubic feet) dataonly replace
   
* 13. New valuelabels option 
   sysuse auto.dta, clear
   format trunk %3.1fc
   texsave make mpg trunk foreign if price > 8000 using "example13.tex", valuelabels replace
   
* 14. Endash testing
	sysuse auto, clear
	keep in 1/5
	replace make = "-32 (-4 to -5)" in 1
	replace make = "-32 (---4 to -----5)" in 2
	replace make = "-32 (x-5 to x-y)" in 3
	texsave make mpg trunk using "example14.tex", title(MPG and trunk space) footnote(Variable trunk measured in cubic feet) replace
	
* 15. Footnote testing
	sysuse auto, clear
	texsave make if price > 8000 using "example15.tex", title(MPG and trunk space) width(0.4\linewidth) footnote(Variable trunk measured in cubic feet) replace
  	
***	
* Decimalalign examples
***
	* Default align is "lSS"
	sysuse auto.dta, clear
	replace price = price/2000.21 in 1/10
	replace price = price/20.21 in 11/l
	replace mpg = mpg/20.21 in 1/10
	replace mpg = mpg/20.21 in 11/l
	replace mpg = -mpg if mod(_n,3)==1
	texsave mpg trunk price in 1/20 using "decimal1.tex", title(MPG and trunk space) footnote(Variable trunk measured in cubic feet) decimal replace

	* User specifies align "SSS"
	texsave mpg trunk price in 1/20 using "decimal2.tex", title(my title) footnote(My footnote) align(SSS) decimal replace

	* String data with mix of text and numbers
	tostring mpg price, replace force format(%5.4fc)
	replace price = "some text" in 10
	texsave mpg trunk price in 1/20 using "decimal3.tex", title(MPG and trunk space) footnote(Variable trunk measured in cubic feet) decimal replace	


use results.dta, clear
cf _all using "results.compare.dta"
	
** EOF

