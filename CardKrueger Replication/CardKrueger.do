
****************************************************
* Card & Krueger (1994) – Fatou Barry Replication
****************************************************

clear all
set more off

* 1. Set working directory
cd "/Users/fatoubarry/Desktop/CardKrueger Replication"

* 2. Start log FIRST so ALL output is saved
log using "ck_replication_results.txt", replace text

* 3. Load dataset
use "fastfood.dta", clear

* 4. Take a quick look at the data (so tables show in log)
describe
codebook var1 var2 var3 var4 var5 var6 var7 var8 var9 var10

* 5. Rename key variables to readable names
*    (based on what we saw in your codebook)
rename var1  state          // 1 = NJ, 0 = PA
rename var3  chain          // chain id
rename var7  wave           // 1 = pre, 2 = post
rename var10 emptot         // total employees at first interview
rename var11 empsk          // number of skilled employees
rename var17 wage_st        // starting wage (string)

* 6. Make sure wage variable is numeric
destring wage_st, replace ignore(".")   // converts "4.25" etc to numeric
rename wage_st wage                     // nicer name

* 7. Construct total employment (like in the paper)
gen emp_tot = emptot + empsk

* 8. Create treatment & post indicators (DiD setup)
gen treated = (state == 1)    // 1 = New Jersey (treated), 0 = Pennsylvania
gen post    = (wave  == 2)    // 1 = after minimum wage increase

*   Check they vary (these tables will also show in the log)
tab treated
tab post

* 9. Main DiD regression on employment
*    Using factor-variable syntax so Stata handles interaction
reg emp_tot i.treated##i.post, robust

*    DiD estimate (NJ vs PA, post vs pre) is:
*    _b[1.treated#1.post]

* 10. DiD regression on log wages
gen lwage = log(wage)    // log wage (fixes previous type mismatch)

reg lwage i.treated##i.post, robust

* 11. Close log
log close

****************************************************
* End of do-file
****************************************************
