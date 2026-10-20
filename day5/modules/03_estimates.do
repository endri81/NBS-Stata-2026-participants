* =====================================================================
* 03_estimates.do  —  module 3: official estimates to Excel (Day 3)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : $root/data/lfs_${quarter}_svy.dta
* Outputs    : $root/output/estimates_${quarter}.xlsx
* Packages   : none
* Called by  : master.do
* =====================================================================
version 17
use "$root/data/lfs_${quarter}_svy.dta", clear
local xl "$root/output/estimates_${quarter}.xlsx"

* National: unemployment, youth unemployment, participation. Each row:
* rate, lower and upper limit, in percent. proportion with a logit
* interval: the limits stay between 0 and 100 even for small rates.
putexcel set "`xl'", sheet("National") replace
putexcel A1 = "Indicator" B1 = "Rate" C1 = "Lower" D1 = "Upper"
local row 2
foreach ind in unemp youth part {
    if "`ind'" == "unemp" svy, subpop(lf): proportion unemp, citype(logit)
    if "`ind'" == "youth" svy, subpop(lf_youth): proportion unemp, citype(logit)
    if "`ind'" == "part"  svy, subpop(wap): proportion lf, citype(logit)
    * column 2 of r(table) is the level 1 (unemployed, or in the labour force)
    matrix T = r(table)
    putexcel A`row' = "`ind'"
    putexcel B`row' = (100 * T[1, 2]) C`row' = (100 * T[5, 2]) D`row' = (100 * T[6, 2])
    local ++row
}

* Regions: one estimate per region in a loop; the name from the value
* label, without its numeric prefix ("1- North" becomes "North").
putexcel set "`xl'", sheet("Regions") modify
putexcel A1 = "Region" B1 = "Rate" C1 = "Lower" D1 = "Upper"
forvalues r = 1/7 {
    svy, subpop(if lf == 1 & region == `r'): proportion unemp, citype(logit)
    matrix T = r(table)
    local name : label (region) `r'
    local name = strtrim(substr("`name'", strpos("`name'", "-") + 1, .))
    local row = `r' + 1
    putexcel A`row' = "`name'"
    putexcel B`row' = (100 * T[1, 2]) C`row' = (100 * T[5, 2]) D`row' = (100 * T[6, 2])
}

putexcel set "`xl'", sheet("Notes") modify
putexcel A1 = "LFS $quarter, design-based estimates, percent, 95% logit intervals"
putexcel A2 = "svyset psu [pweight = wgt_final], strata(district)"
putexcel A3 = "Youth = 15 to $youth_max years"
putexcel A4 = "Run on `c(current_date)' with Stata `c(stata_version)'"
