* =====================================================================
* catchup_D2_S3.do  —  Day 2 catch-up: end of Part 3, The same table, turned
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 2 (17 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_jan.dta, lfs_feb.dta, lfs_mar.dta
*              data/lfs_person.dta, lfs_hh.dta, lfs_coding.dta
*              data/lfs_district_month.dta
* Outputs    : data/lfs_q1_appended.dta
*              logs/day2.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 3. To keep working, save this
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

* ---- Part 3: reshape the district x month table ------------------------
use "data/lfs_district_month.dta", clear
list in 1/6
reshape wide persons, i(district_q) j(int_month)
list in 1/6
reshape long persons, i(district_q) j(int_month)
assert _N == 78

log close
