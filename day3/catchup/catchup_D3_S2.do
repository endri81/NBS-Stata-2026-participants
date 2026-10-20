* =====================================================================
* catchup_D3_S2.do  —  Day 3 catch-up: end of Part 2, The design
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 3 (18 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta (rebuilt by day1/catchup/catchup_D1_S9.do if missing)
* Outputs    : logs/day3.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 2. To keep working, save this
*              file as day3/my_day3.do and add the next parts below it.
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

log close
