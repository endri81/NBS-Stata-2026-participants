* =====================================================================
* 04_model.do  —  module 4: the model and the price series (Day 4)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : $root/data/lfs_${quarter}_svy.dta, $root/data/cpi_divisions_long.dta
* Outputs    : $root/output/margins_${quarter}.png, $root/output/infl_${quarter}.png,
*              $root/output/model_${quarter}.xlsx
* Packages   : none
* Called by  : master.do
* =====================================================================
version 17
use "$root/data/lfs_${quarter}_svy.dta", clear
local xl "$root/output/model_${quarter}.xlsx"

* Who is more likely to be unemployed: design-based logit, read through
* margins (education left out: empty cells, Day 4 Part 4).
svy, subpop(lf): logit unemp i.ilo_sex i.agegrp i.region
margins i.agegrp
matrix M = r(table)
marginsplot, title("Predicted unemployment rate by age group") ///
    ytitle("Probability") note("Source: NBS, LFS $quarter (teaching file), design-based")
graph export "$root/output/margins_${quarter}.png", replace width(1600)
putexcel set "`xl'", sheet("Margins") replace
putexcel A1 = "Age group" B1 = "Rate" C1 = "Lower" D1 = "Upper"
forvalues a = 1/4 {
    local name : label (agegrp) `a'
    local row = `a' + 1
    putexcel A`row' = "`name'"
    putexcel B`row' = (100 * M[1, `a']) C`row' = (100 * M[5, `a']) D`row' = (100 * M[6, `a'])
}

* Inflation: all items, year on year; the latest month to Excel.
use "$root/data/cpi_divisions_long.dta", clear
keep if division == 0
tsset month, monthly
generate yoy = 100 * (cpi / L12.cpi - 1)
tsline yoy, yline(0) title("Year-on-year inflation, all items") ///
    ytitle("Per cent") note("Source: NBS CPI")
graph export "$root/output/infl_${quarter}.png", replace width(1600)
putexcel set "`xl'", sheet("CPI") modify
putexcel A1 = "Month" B1 = "Inflation"
putexcel A2 = (string(month[_N], "%tmMonth_CCYY")) B2 = (yoy[_N])
