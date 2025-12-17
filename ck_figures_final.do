****************************************************
* Card & Krueger Replication – FIGURES ONLY
* Fatou Barry
****************************************************

clear all
set more off

* Set directory
cd "/Users/fatoubarry/Desktop/CardKrueger Replication"

* Load data
use fastfood.dta, clear

* Rename key variables (based on your data)
rename var18 state
rename var20 wave
rename var22 emp_tot
rename var21 wage

* Keep valid waves
keep if wave==1 | wave==2

* Treatment indicators
gen treated = (state==1)
gen post = (wave==2)
gen did = treated*post

* Log wage
gen lwage = log(wage)

****************************************************
* FIGURE 1: Mean Employment by Group & Time
****************************************************
preserve
collapse (mean) emp_tot, by(treated post)

label define tr 0 "PA (Control)" 1 "NJ (Treated)"
label values treated tr
label define po 0 "Pre" 1 "Post"
label values post po

graph bar emp_tot, over(post) over(treated) ///
 title("Mean Employment by State and Period") ///
 ytitle("Mean Total Employment")

graph export "Figure1_Mean_Employment.png", replace
restore

****************************************************
* FIGURE 2: Mean Wage by Group & Time
****************************************************
preserve
collapse (mean) wage, by(treated post)

label values treated tr
label values post po

graph bar wage, over(post) over(treated) ///
 title("Mean Starting Wage by State and Period") ///
 ytitle("Mean Starting Wage")

graph export "Figure2_Mean_Wage.png", replace
restore

****************************************************
* FIGURE 3: Log Wage Distribution by State
****************************************************
twoway ///
 (kdensity lwage if treated==1, lpattern(solid)) ///
 (kdensity lwage if treated==0, lpattern(dash)), ///
 legend(order(1 "NJ (Treated)" 2 "PA (Control)")) ///
 title("Distribution of Log Starting Wages") ///
 xtitle("Log Wage") ytitle("Density")

graph export "Figure3_Log_Wage_Distribution.png", replace

****************************************************
* END
****************************************************
