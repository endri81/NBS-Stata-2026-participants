* =====================================================================
* catchup_D3_S8.do  —  Day 3 catch-up: end of Part 8, The estimates table
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 3 (18 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta (rebuilt by day1/catchup/catchup_D1_S9.do if missing)
* Outputs    : data/lfs_svy.dta, output/estimates_q1.xlsx, logs/day3.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 8. To keep working, save this
*              file as day3/my_day3.do and add the next parts below it.
*              Close Excel first: Part 8 writes to its file.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture mkdir "output"
* Day 3 starts from Day 1's analysis file: rebuild it if it is missing.
capture confirm file "data/lfs_teach.dta"
if _rc do "day1/catchup/catchup_D1_S9.do"
capture log close
log using "logs/day3.log", replace text

* ---- Part 1: weights ---------------------------------------------------
* Task 2: three weights; wgt_final is the one for estimates.
use "data/lfs_teach.dta", clear
describe wgt_base wgt_adj wgt_final
summarize wgt_final
* Task 3: weights differ by district because districts were sampled
* and interviewed differently.
tabstat wgt_final, statistics(min mean max n) by(district)
* Task 4: the weights add up to the population in scope (101,364).
summarize wgt_final
display %12.0fc r(sum)
* Task 5: a quick weighted count. iweight gives no standard error.
tabulate region [iweight = wgt_final]

* ---- Part 2: the design ------------------------------------------------
* Task 6: count each PSU once, then the PSUs of each district.
egen first_psu = tag(district psu)
bysort district: egen n_psu = total(first_psu)
tabulate n_psu if first_psu
* Task 7: NBS's final weight is base weight times district adjustment.
generate check_w = wgt_base * wgt_adj
assert abs(check_w - wgt_final) < 1e-4
* Tasks 8-9: the base weight is fixed within a PSU, the adjustment
* within a district: proof that the weights follow the design.
bysort psu: assert wgt_base == wgt_base[1]
bysort district: assert wgt_adj == wgt_adj[1]
drop first_psu n_psu check_w

* ---- Part 3: declaring the design -------------------------------------
* Task 10: PSU = cluster, district = stratum, wgt_final = weight.
svyset psu [pweight = wgt_final], strata(district)
* Task 11: 26 strata, 146 PSUs, no stratum with a single PSU.
svydescribe
* Task 12: the declaration is saved with the data.
save "data/lfs_svy.dta", replace
use "data/lfs_svy.dta", clear
svyset

* ---- Part 4: estimates -------------------------------------------------
* Task 13: 0/1 flags, never missing, so no row drops out of an estimate.
generate wap = (ilo_age >= 15)
generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
generate unemp = (ilo_lfs19 == 2)
generate emp = (ilo_lfs19 == 1)
tabulate ilo_lfs19 lf, missing
* Tasks 14-18: mean, total, shares, the unemployment rate, its DEFF.
svy: mean ilo_age
svy: total emp
svy, subpop(wap): proportion ilo_lfs19
svy: ratio unemp/lf
estat effects

* ---- Part 5: subpopulations --------------------------------------------
* Task 19: the same rate as a mean within the labour force.
svy, subpop(lf): mean unemp
* Tasks 20-21: one estimate per region, per sex. subpop(), never if.
svy, subpop(lf): mean unemp, over(region)
svy, subpop(wap): mean lf, over(region)
svy, subpop(wap): mean lf, over(ilo_sex)

* ---- Part 6: survey tables ---------------------------------------------
* Tasks 22-24: weighted tables with intervals and the design-based test.
svy: tabulate region
svy: tabulate region, count se ci format(%9.0fc)
svy: tabulate region, percent ci format(%5.1f)
svy: tabulate region ilo_lfs19, row percent format(%5.1f)

* ---- Part 7: precision -------------------------------------------------
* Task 25: CV of the regional rates; NBS's threshold decides flagging.
svy, subpop(lf): mean unemp, over(region)
estat cv

* ---- Part 8: the estimates table ---------------------------------------
* Tasks 26-27: copy r(table) at once (the next command replaces it),
* transpose so regions are rows, write to Excel with names.
svy, subpop(lf): mean unemp, over(region)
matrix list r(table)
matrix T = r(table)'
putexcel set "output/estimates_q1.xlsx", sheet("Unemployment") replace
putexcel A1 = matrix(T), names
* Task 28: participation on a second sheet, release columns only;
* the Notes sheet documents the design and the source.
svy, subpop(wap): mean lf, over(region)
matrix P = r(table)'
matrix P = P[1..., 1..2], P[1..., 5..6]
putexcel set "output/estimates_q1.xlsx", sheet("Participation") modify
putexcel A1 = matrix(P), names
putexcel set "output/estimates_q1.xlsx", sheet("Notes") modify
putexcel A1 = "LFS Q1 2026, design-based estimates"
putexcel A2 = "svyset psu [pweight = wgt_final], strata(district)"
putexcel A3 = "Source: NBS, LFS Q1 2026 (teaching file)"

log close
