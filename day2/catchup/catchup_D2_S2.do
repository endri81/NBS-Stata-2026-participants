* =====================================================================
* catchup_D2_S2.do  —  Day 2 catch-up: end of Part 2, Joining files by their key
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 2 (17 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_jan.dta, lfs_feb.dta, lfs_mar.dta
*              data/lfs_person.dta, lfs_hh.dta, lfs_coding.dta
* Outputs    : data/lfs_q1_appended.dta
*              logs/day2.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 2. To keep working, save this
*              file as day2/my_day2.do and add the next parts below it.
*              Close Excel and Word first: Part 7 writes to their files.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture mkdir "output"
capture log close
log using "logs/day2.log", replace text

* ---- Part 1: append the three months -----------------------------------
use "data/lfs_jan.dta", clear
append using "data/lfs_feb.dta" "data/lfs_mar.dta", generate(source)
count
tabulate source
assert _N == 5888
tabulate district_q int_month
save "data/lfs_q1_appended.dta", replace

* ---- Part 2: merge households, persons, coding ------------------------
use "data/lfs_hh.dta", clear
isid unique_hhd
use "data/lfs_person.dta", clear
isid unique_ind
merge m:1 unique_hhd using "data/lfs_hh.dta", assert(match) nogenerate
merge 1:1 unique_ind using "data/lfs_coding.dta"
tabulate _merge ilo_lfs19, missing
assert ilo_lfs19 == 1 if _merge == 3
count
isid unique_ind
assert _N == 5888

log close
